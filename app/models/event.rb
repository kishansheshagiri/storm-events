class Event < ApplicationRecord
  belongs_to :episode
  has_many :locations, dependent: :destroy
  has_many :fatalities, dependent: :destroy
  accepts_nested_attributes_for :locations, allow_destroy: true
  accepts_nested_attributes_for :fatalities, allow_destroy: true
  accepts_nested_attributes_for :episode
  validates :id, presence: true, uniqueness: true

  def self.getRecords(page)
    find_by_sql("SELECT e.id as id, storm_type,
          c.name as county_name, c.timezone as timezone, s.name as state_name,
          begin_time, source, property_damage, crop_damage
        FROM events e
        INNER JOIN us_states s
          ON e.state_fips = s.id
        INNER JOIN counties c
          ON e.county_fips = c.fips AND e.state_fips = c.us_state_id")
  end

  def self.getDetails(id)
    @events = find_by_sql("SELECT e.id as id,
          storm_type,
          c.name as county_name, c.fips as county_fips, c.timezone as timezone,
          s.name as state_name, s.id as state_fips,
          begin_time, end_time, source,
          e.forecast_office as forecast_office,
            fo.name as forecast_office_name,
            state_fo.name as forecast_office_state,
          magnitude, magnitude_type,
          property_damage, crop_damage,
          narrative,
          episode_id, ep.description as episode_narrative
        FROM events e
        INNER JOIN us_states s
          ON e.id = #{id} AND e.state_fips = s.id
        INNER JOIN counties c
          ON e.county_fips = c.fips AND e.state_fips = c.us_state_id
        INNER JOIN forecast_offices fo
          ON e.forecast_office = fo.id
        INNER JOIN us_states state_fo
          ON fo.us_state_id = state_fo.id
        INNER JOIN episodes ep
          ON e.episode_id = ep.id")

    @events.each do |event|
      event.locations << Location.find_by_sql("
          SELECT * FROM locations WHERE event_id = #{event.id}")
      event.fatalities << Fatality.find_by_sql("
          SELECT * FROM fatalities WHERE event_id = #{event.id}")
    end
  end

  def save_sql(params)
    return false if !params_valid?(params)
    event_exists = Event.find_by_sql("SELECT  1 AS one FROM events WHERE id = #{params[:id]} LIMIT 1")
    return false if !event_exists.blank?
    insert_values = []
    time_now = Time.now.to_s(:db)

    begin_time_new = DateTime.new(params["begin_time(1i)"].to_i, params["begin_time(2i)"].to_i,
        params["begin_time(3i)"].to_i, params["begin_time(4i)"].to_i, params["begin_time(5i)"].to_i).to_s(:db)

    end_time_new = DateTime.new(params["end_time(1i)"].to_i, params["end_time(2i)"].to_i,
        params["end_time(3i)"].to_i, params["end_time(4i)"].to_i, params["end_time(5i)"].to_i).to_s(:db)

    insert_values.push "(#{params[:id]}, '#{params[:storm_type]}', '#{begin_time_new}', '#{end_time_new}',
        #{params[:state_fips]}, #{params[:county_fips]}, '#{params[:source]}', '#{params[:forecast_office]}',
        #{params[:magnitude]}, '#{params[:magnitude_type]}', #{params[:property_damage]}, #{params[:crop_damage]},
        '#{params[:narrative]}', #{params[:episode_id]}, '#{time_now}', '#{time_now}')"

    sql_to_insert = "INSERT INTO events (id, storm_type, begin_time, end_time, state_fips,
            county_fips, source, forecast_office, magnitude, magnitude_type,
            property_damage, crop_damage, narrative, episode_id, created_at, updated_at) VALUES #{insert_values.join(", ")}"

    Event.connection.execute(sql_to_insert)

    if params[:fatalities_attributes]
      params[:fatalities_attributes].each do |fatality|
        fatalities_params = params[:fatalities_attributes]["#{fatality}"]
        fatalities_params[:event_id] = params[:id]

        @fatality_new = Fatality.new(fatalities_params)
        @fatality_new.save
      end
    end

    if params[:locations_attributes]
      params[:locations_attributes].each do |location|
        locations_params = params[:locations_attributes]["#{location}"]
        locations_params[:event_id] = params[:id]

        @location_new = Location.new(locations_params)
        @location_new.save
      end
    end

    return true
  end

  def update_sql(params)
    params[:id] = id
    return false if !params_valid?(params)
    update_values = []
    time_now = Time.now.to_s(:db)

    begin_time_new = DateTime.new(params["begin_time(1i)"].to_i, params["begin_time(2i)"].to_i,
        params["begin_time(3i)"].to_i, params["begin_time(4i)"].to_i, params["begin_time(5i)"].to_i).to_s(:db)

    end_time_new = DateTime.new(params["end_time(1i)"].to_i, params["end_time(2i)"].to_i,
        params["end_time(3i)"].to_i, params["end_time(4i)"].to_i, params["end_time(5i)"].to_i).to_s(:db)

    sql_for_update = "UPDATE events SET storm_type = '#{params[:storm_type]}', begin_time = '#{begin_time_new}',
        end_time = '#{end_time_new}', state_fips = #{params[:state_fips]}, county_fips = #{params[:county_fips]},
        source = '#{params[:source]}', forecast_office = '#{params[:forecast_office]}', magnitude = #{params[:magnitude]},
        magnitude_type = '#{params[:magnitude_type]}', property_damage = #{params[:property_damage]},
        crop_damage = #{params[:crop_damage]}, narrative = '#{params[:narrative]}', episode_id = #{params[:episode_id]},
        updated_at = '#{time_now}' WHERE id = #{params[:id]}"

    Event.connection.execute(sql_for_update)

    if params[:fatalities_attributes]
      params[:fatalities_attributes].each do |fatality|
        fatalities_params = params[:fatalities_attributes]["#{fatality}"]
        fatalities_params[:event_id] = params[:id]

        fatalities.update(fatalities_params)
      end
    end

    if params[:locations_attributes]
      params[:locations_attributes].each do |location|
        locations_params = params[:locations_attributes]["#{location}"]
        locations_params[:event_id] = params[:id]

        locations.update(locations_params)
      end
    end

    return true
  end

  def delete_sql
    params = Hash.new
    params[:id] = id
    params[:episode_id] = episode_id
    return false if !params_valid?(params)

    event_exists = Event.find_by_sql("SELECT  1 AS one FROM events WHERE id = #{:id} LIMIT 1")
    return false if event_exists.blank?

    sql_to_delete = "DELETE FROM events WHERE id = #{id}"
    Event.connection.execute(sql_to_delete)

    return true
  end

  private

  def params_valid?(params)
    episode_new = Episode.find_by_sql("SELECT * FROM episodes WHERE id = #{params[:episode_id]} LIMIT 1")
    return false if episode_new.blank?

    episode_exists = Episode.find_by_sql("SELECT  1 AS one FROM episodes
        WHERE id = #{params[:episode_id]} AND (id != #{params[:episode_id]}) LIMIT 1")
    return false if !episode_exists.blank?

    return true
  end
end

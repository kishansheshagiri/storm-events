class Event < ApplicationRecord
  belongs_to :episode
  has_many :locations, dependent: :destroy
  has_many :fatalities, dependent: :destroy
  attr_accessor :county_name, :state_name, :episode_narrative

  after_initialize do
    self.county_name = nil unless @attributes.key?("county_name")
    self.state_name = nil unless @attributes.key?("state_name")
    self.episode_narrative = nil unless @attributes.key?("episode_narrative")
  end

  def county_name
    @attributes["county_name"].value
  end

  def county_name=(value)
    @attributes["county_name"] = value
  end

  def state_name
    @attributes["state_name"].value
  end

  def state_name=(value)
    @attributes["state_name"] = value
  end

  def episode_narrative
    @attributes["episode_narrative"].value
  end

  def episode_narrative=(value)
    @attributes["episode_narrative"] = value
  end

  def self.getRecords(page)
    paginate_by_sql("SELECT e.id as id, storm_type,
          c.name as county_name, s.name as state_name,
          begin_time, source
        FROM events e
        INNER JOIN us_states s
          ON e.state_fips = s.id
        INNER JOIN counties c
          ON e.county_fips = c.fips AND e.state_fips = c.us_state_id",
        page: page, per_page: 10)
  end

  def self.getDetails(id)
    @events = find_by_sql("SELECT e.id as id,
          storm_type,
          c.name as county_name, s.name as state_name,
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
end

json.extract! event, :id, :id, :storm_type, :begin_time, :end_time, :state_fips, :county_fips, :source, :forecast_office, :magnitude, :magnitude_type, :property_damage, :crop_damage, :narrative, :episode_id, :created_at, :updated_at
json.url event_url(event, format: :json)

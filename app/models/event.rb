class Event < ApplicationRecord
  belongs_to :episode
  has_many :locations
  has_many :fatalities

  def self.getRecords
    find_by_sql("SELECT e.id as id, storm_type, c.name as county_name,
                   s.name as state_name, begin_time, source
                 FROM events e
                 INNER JOIN us_states s
                   ON e.state_fips = s.id
                 INNER JOIN counties c
                   ON e.county_fips = c.fips AND e.state_fips = c.us_state_id
                 LIMIT 10
               ")
  end
end

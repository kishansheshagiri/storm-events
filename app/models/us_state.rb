class UsState < ApplicationRecord
  has_many :counties
  has_many :forecast_offices
end

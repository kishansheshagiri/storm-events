class Event < ApplicationRecord
  belongs_to :episode
  has_many :locations
end

class Fatality < ApplicationRecord
  belongs_to :event
  accepts_nested_attributes_for :event
end

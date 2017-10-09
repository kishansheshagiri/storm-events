class Episode < ApplicationRecord
  has_many :events, dependent: :destroy
  accepts_nested_attributes_for :events, allow_destroy: true
  validates :id, presence: true, uniqueness: true
end

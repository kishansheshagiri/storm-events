class User < ApplicationRecord
  before_save { self.email = email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  EMAIL_VALIDATION_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false },
      format: { with: EMAIL_VALIDATION_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }
end

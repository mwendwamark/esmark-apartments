class User < ApplicationRecord
  has_secure_password
  validates :email, :name, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :name, length: { minimum: 2, maximum: 64 }
  validates :password, length: { minimum: 6, maximum: 64 }
end

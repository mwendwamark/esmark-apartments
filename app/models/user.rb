class User < ApplicationRecord
  has_secure_password
  validates :email, :name, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6}
end

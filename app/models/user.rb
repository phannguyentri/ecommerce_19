class User < ApplicationRecord
  has_many :orders
  has_many :rates
  has_many :comments
  has_many :suggests

  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password
  validates :name, presence: true, length: {maximum: Settings.maximum_name}
  validates :address, presence: true, length: {maximum: Settings.maximum_address}
  validates :phone, presence: true, numericality: {only_integer: true},
    length: {in: Settings.min_range_phone..Settings.max_range_phone}
  validates :email, presence: true, length: {maximum: Settings.maximum_name_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.minimum}, allow_nil: true

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end
end

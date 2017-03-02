class Order < ApplicationRecord
  belongs_to :user
  has_many :orderitems

  validates :name, presence: true, length: {maximum: Settings.maximum_name}
  validates :address, presence: true,
    length: {maximum: Settings.maximum_address}
  validates :phone, presence: true, numericality: {only_integer: true},
    length: {in: Settings.min_range_phone..Settings.max_range_phone}
  validates :user_id, presence: true

  scope :newest, ->{order "created_at desc"}
end

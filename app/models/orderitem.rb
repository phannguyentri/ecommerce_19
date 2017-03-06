class Orderitem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, to: :product, prefix: true

  scope :newest, ->{order created_at: :desc}
end

class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :products, dependent: :destroy

  delegate :name, to: :category, prefix: true

  validates :category_id, presence: true
  validates :name, presence: true, length: {maximum: Settings.maximum_name}

  scope :list_subcategory_desc, ->{order "created_at desc"}
end

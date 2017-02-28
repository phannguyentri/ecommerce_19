class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.maximum_name}

  scope :list_category_desc, ->{order "created_at desc"}
end

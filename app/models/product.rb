class Product < ApplicationRecord
  belongs_to :subcategory
  has_many :rates, dependent: :destroy
  has_many :orderitems, dependent: :destroy
  has_many :comments, dependent: :destroy

  delegate :name, to: :subcategory, prefix: true

  mount_uploader :image, PictureUploader

  validates :name, presence: true, length: {maximum: Settings.maximum_name}
  validates :subcategory_id, presence: true
  validates :info, presence: true, length: {maximum: Settings.maximum_info}
  validates :price, presence: true, numericality: {only_integer: true}
  validates :image, presence: true, allow_nil: true

  scope :list_products_desc, ->{order "created_at desc"}
end

class Product < ApplicationRecord
  belongs_to :subcategory
  has_many :rates
  has_many :orderitems
  has_many :comments
end

class Suggest < ApplicationRecord
  belongs_to :user
  belongs_to :subcategory

  enum status: {pending: 1, accepted: 2, reject: 3}

  validates :name, presence: true, length: {maximum: Settings.max_name_suggest}
  validates :subcategory_id, presence: true

  delegate :name, to: :subcategory, prefix: true

  scope :newest, ->{order created_at: :desc}
end

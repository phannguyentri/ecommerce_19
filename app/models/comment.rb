class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  delegate :name, to: :user, prefix: true

  validates :content, presence: true, length: {maximum: Settings.maximum_comment}

  scope :comments_newest, ->{order created_at: :desc}
end

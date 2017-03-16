class Order < ApplicationRecord
  belongs_to :user
  has_many :orderitems, dependent: :destroy

  enum status: {pending: 1, accepted: 2, reject: 3}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: Settings.maximum_name}
  validates :email, presence: true, length: {maximum: Settings.maximum_name_email},
    format: {with: VALID_EMAIL_REGEX}
  validates :address, presence: true, length: {maximum: Settings.maximum_address}
  validates :phone, presence: true, numericality: {only_integer: true},
    length: {in: Settings.min_range_phone..Settings.max_range_phone}
  validates :user_id, presence: true

  scope :newest, ->{order created_at: :desc}
  scope :this_month, -> do
    where("created_at >= ? AND created_at <= ?",
    Time.now.beginning_of_month, Time.now.end_of_month)
  end
  scope :last_month, -> do
    where("created_at >= ? AND created_at <= ?",
    Settings.one_month_ago.month.ago.beginning_of_month,
    Settings.one_month_ago.month.ago.end_of_month)
  end
  scope :two_month_ago, -> do where("created_at >= ? AND created_at <= ?",
    Settings.two_month_ago.month.ago.beginning_of_month,
    Settings.two_month_ago.month.ago.end_of_month)
  end
end

class Admin::StatisticsController < ApplicationController
  before_action :verify_admin?
  
  def index
    orders_this_month = Order.this_month
    orders_last_month = Order.last_month
    orders_two_month_ago = Order.two_month_ago
    @data_total = data_statistics  orders_last_month, orders_this_month,
      orders_two_month_ago
    @data_quantity_orders = data_statistics  orders_last_month, orders_this_month,
      orders_two_month_ago, Settings.status_false
  end
end

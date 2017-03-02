class AddDefaultValueToOrders < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :status, :integer, default: 1
    change_column :order_items, :status, :boolean, default: true
  end
end

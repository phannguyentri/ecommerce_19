class AddDefaultValueToProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :average_rate, :integer, :default: 0
  end
end

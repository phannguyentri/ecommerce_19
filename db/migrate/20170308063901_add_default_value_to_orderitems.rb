class AddDefaultValueToOrderitems < ActiveRecord::Migration[5.0]
  def change
    change_column :orderitems, :status, :boolean, default: true
  end
end

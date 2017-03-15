class ChangeColumnSuggests < ActiveRecord::Migration[5.0]
  def change
    rename_column :suggests, :subcategorie_id, :subcategory_id
    change_column :suggests, :status, :integer, default: 1
  end
end

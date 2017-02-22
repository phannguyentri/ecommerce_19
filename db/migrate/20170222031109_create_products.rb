class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :subcategorie, foreign_key: true
      t.string :name
      t.string :info
      t.string :image
      t.bigint :price
      t.integer :average_rate

      t.timestamps
    end
  end
end

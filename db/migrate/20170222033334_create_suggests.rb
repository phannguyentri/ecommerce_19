class CreateSuggests < ActiveRecord::Migration[5.0]
  def change
    create_table :suggests do |t|
      t.references :user, foreign_key: true
      t.references :subcategorie, foreign_key: true
      t.string :name
      t.integer :status

      t.timestamps
    end
  end
end

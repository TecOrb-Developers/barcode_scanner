class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.references :restaurant_owner, index: true, foreign_key: true
      t.references :chef, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

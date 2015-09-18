class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
      t.string :name
      t.string :email
      t.integer :phone
      t.references :restaurant_owner, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

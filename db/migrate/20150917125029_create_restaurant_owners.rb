class CreateRestaurantOwners < ActiveRecord::Migration
  def change
    create_table :restaurant_owners do |t|
      t.string :name
      t.string :restaurant_name
      t.string :email
      t.integer :phone

      t.timestamps null: false
    end
  end
end

class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :restaurant_name
      t.string :email
      t.string :image
      t.string :phone

      t.timestamps null: false
    end
  end
end

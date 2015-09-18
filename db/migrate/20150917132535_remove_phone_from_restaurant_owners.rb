class RemovePhoneFromRestaurantOwners < ActiveRecord::Migration
  def change
    remove_column :restaurant_owners, :phone, :integer
    remove_column :chefs, :phone, :integer
    add_column :restaurant_owners, :phone_number, :numeric
    add_column :restaurant_owners, :image, :string
    add_column :chefs, :phone_number, :numeric
    add_column :chefs, :image, :string


  end
end

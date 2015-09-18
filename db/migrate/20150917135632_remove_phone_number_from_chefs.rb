class RemovePhoneNumberFromChefs < ActiveRecord::Migration
  def change
    remove_column :chefs, :phone_number, :numeric
    remove_column :restaurant_owners, :phone_number, :numeric
    add_column :chefs, :phone, :string
    add_column :restaurant_owners,:phone, :string
  end
end

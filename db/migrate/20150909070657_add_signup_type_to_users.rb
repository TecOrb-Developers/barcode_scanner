class AddSignupTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :signup_type, :string
    add_column :users, :provider_id, :string
    add_column :users, :provider_name, :string
  end
end

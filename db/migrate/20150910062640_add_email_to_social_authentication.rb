class AddEmailToSocialAuthentication < ActiveRecord::Migration
  def change
     add_column :social_authentications, :email, :string
     remove_column :users, :signup_type, :string
     remove_column :users, :provider_id, :string
	 remove_column :users, :provider_name, :string
  end
end

class RemoveUserIdAndMemberIdFromIngredients < ActiveRecord::Migration
  def change
  	 remove_column :ingredients, :user_id, :integer
  	 remove_column :ingredients, :member_id, :integer
     remove_column :ingredients, :product_name, :string
     remove_column :ingredients, :image_urls, :string
  end
end

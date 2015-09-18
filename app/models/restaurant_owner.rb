class RestaurantOwner < ActiveRecord::Base
	 has_many :chefs, dependent: :destroy
	 has_many :products, dependent: :destroy
	 mount_uploader :image, AvatarUploader

end

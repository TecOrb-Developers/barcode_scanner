class Restaurant < ActiveRecord::Base
	has_many :chef, dependent: :destroy
	has_many :product, dependent: :destroy
	mount_uploader :image, AvatarUploader
end

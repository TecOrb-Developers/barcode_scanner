class Chef < ActiveRecord::Base
  belongs_to :restaurant
  has_many :products
  mount_uploader :image, AvatarUploader
end

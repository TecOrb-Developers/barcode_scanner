class Member < ActiveRecord::Base
  belongs_to :user
  has_many :preventives , dependent: :destroy
  validates :name, :presence=>true
  mount_uploader :image, AvatarUploader

end

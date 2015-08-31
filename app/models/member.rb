class Member < ActiveRecord::Base
  belongs_to :user
  has_many :preventives , dependent: :destroy
  has_many :ingredients, dependent: :destroy 
  validates :name, :presence=>true
end

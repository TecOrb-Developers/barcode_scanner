class Chef < ActiveRecord::Base
  belongs_to :restaurant_owner
  has_many :products, dependent: :destroy
end

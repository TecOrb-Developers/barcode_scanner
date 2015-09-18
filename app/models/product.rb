class Product < ActiveRecord::Base
  belongs_to :restaurant_owner
  belongs_to :chef
 #scope :details, -> {Product.where(restaurant_owner_id: params[:id])}
end

class Product < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :chef
  has_many :product_ingredients
  has_many :ingredients, through: :product_ingredients
end

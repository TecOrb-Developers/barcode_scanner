class IngredientsController < ApplicationController

  def ingredients_list
	@response = User.get_ingredients(params[:upc])
        render :json => {
	        	                :response_code => 200,
	        	                :response_message => "ingrdients list"  ,
	        	                :ingredients=>JSON.parse(@response.body)["response"]["data"].first["ingredients"],
	        	                :product_name=>JSON.parse(@response.body)["response"]["data"].first["product_name"] ,
	        	                :image=> JSON.parse(@response.body)["response"]["data"].first["image_urls"],
	        	                :@member=>@user.members.all
	        	      }
  end
  
  def add_ingredients
  	@user = User.find_by_id(params[:id])
  	@ingredient = @user.ingredients.create!(:ingredient_name=>params[:ingredient_name])
  	if @ingredient.save
  	 render :json => {
	        	                :response_code => 200,
	        	                :response_message => "ingrdients added successfully" ,
	        	                :ingredient_list=> @ingredient
	        	       }
	   
	   end
	 end
 end
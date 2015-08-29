class IngredientsController < ApplicationController

def ingredients_list
	# @user = User.find_by_id(params[:id])
    # @member = @user.members.all
    @response = User.get_ingredients(params[:upc])
    p"++++++++++++++++++++#{inspect.@response}******************"
    render :json => {
	        	                :response_code => 200,
	        	                :response_message => "ingrdients list"  ,
	        	                :ingredients=>JSON.parse(@response.body)["response"]["data"].first["ingredients"],
	        	                :product_name=>JSON.parse(@response.body)["response"]["data"].first["product_name"] ,
	        	                :image=> JSON.parse(@response.body)["response"]["data"].first["image_urls"]
	        	      }
    end
end

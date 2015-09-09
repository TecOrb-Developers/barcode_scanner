class IngredientsController < ApplicationController
 include ApplicationHelper

  def ingredients_list
	@response = get_ingredients(params[:upc])
	if @response 

        render :json => {
	        	                :response_code => 200,
	        	                :ingredient_list => {
	        	                :product_name=>@response["product_name"],
	        	                :image=> @response["image"].first,
	        	                :ingredients=>@response["ingredients"]
	        	            }
	        	      }
	 else
	 	  render :json => {
	        	                :response_code => 500,
	        	                :response_message => "Product is not available. we will include this as soon as possible." 
							}
	 end
  end

  def scan_upc
  	@user = User.find_by_id(params[:user_id])
  	if @user.present?  	
  	 	@result = search_by_upc(@user,params[:upc])	
	  	if @result
	  		if @result["scan_state"] == "not"
	  			@r = "unsafe"
	  		elsif @result["scan_state"] == "not sure"
	  			@r ="not sure"
	  		else
	  			@r = "safe"
	  		end
	  		scan_history = @user.scan_histories.create(:product_name => @result["product"]["product_name"],:result =>@r,:unsafe_users => @result["unsafe_users"],:history_type => "scan",:image => @result["product"]["image"].first)
	        render :json => {
	                :response_code => 200,
	                :response_message => "Result is successfully fetched",
	                :product_name=>@result["product"]["product_name"],
	                :image=> @result["product"]["image"].first,
	                :ingredients => @result["product"]["ingredients"],	                
	                :user_result => @result["user_result"],
	                :members_result => @result["members_result"]
	    	      }
	    else
	   		render :json => {
        	                :response_code => 500,
        	                :response_message => "Product is not available. we will include this as soon as possible." 
						}
	    end	      
	else
	   render :json => {
	        	                :response_code => 500,
	        	                :response_message => "User does not exist" 
							}
	end
  end


  def select_searched_product
  	@user = User.find_by_id(params[:user_id])
  	if @user.present?  	
  	 	@result = search_by_upc(@user,params[:upc])	
	  	if @result
	  		search_history = @user.scan_histories.create(:product_name => @result["product"]["product_name"],:result => @result["scan_state"] ? "safe" : "unsafe",:unsafe_users => @result["unsafe_users"],:history_type => "search",:image => @result["product"]["image"].first)
	        render :json => {
	                :response_code => 200,
	                :response_message => "Result is successfully fetched",
	                :product_name=>@result["product"]["product_name"],
	                :image=> @result["product"]["image"].first,
	                :ingredients => @result["product"]["ingredients"],	                
	                :user_result => @result["user_result"],
	                :members_result => @result["members_result"]
	    	      }
	    else
	   		render :json => {
        	                :response_code => 500,
        	                :response_message => "Product is not available. we will include this as soon as possible." 
						}
	    end	      
	else
	   render :json => {
	        	                :response_code => 500,
	        	                :response_message => "User does not exist" 
							}
	end
  end
  
   def search_product_by_name
		@user = User.find_by_id(params[:user_id])
	  	if @user.present?  		
		  	@response = search_product(params[:name])
			if @response 
		        render :json => {
	        	                :response_code => 200,
	        	                :response_message => "Result is successfully fetched" ,	        	               
	        	                :products => @response
			        	      }
			 else
			 	  render :json => {
			        	                :response_code => 500,
			        	                :response_message => "Product is not available. we will include this as soon as possible." 
									}
			 end
		else
		   render :json => {
		        	                :response_code => 500,
		        	                :response_message => "User does not exist" 
								}
		end
	end

 
  def search_ingredients
   @ingredients = Ingredient.where("(ingredient_name ILIKE (?)) or (ingredient_name ILIKE (?))", "#{params[:ingredient]}%","%#{params[:ingredient]}%")
   render :json => {
	        	                :response_code => 200,
	        	                :response_message => "Ingredients lists" ,
	        	                :ingredient_list=> @ingredients.as_json(:only=>[:id,:ingredient_name])
	        	       }
  end

 def upload_file
 	Ingredient.upload_file(params[:file][:file])
 	redirect_to :back
 end
end
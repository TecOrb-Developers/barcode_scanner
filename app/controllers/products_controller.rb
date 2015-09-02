class ProductsController < ApplicationController
	def product_list
		@products = User.get_products(params[:name])
		if JSON.parse(@products.body)["response"]["data"]
         render :json => {
	        	                :response_code => 200,
	        	                :response_message => "products list"  ,
	        	                :product_name=>JSON.parse(@products.body)["response"]["data"].as_json(:only => ['product_name','ean13','image_urls'])
	        	                
	        	                
	        	      }
	        	  else
	         render :json => {
	        	                :response_code => 200,
	        	                :response_message => "products not found"  
	        	              }	  	
	    end 
    end	
 end

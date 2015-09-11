module ApplicationHelper
require 'uri'
	def api_authentication
		auth = OAuth::AccessToken.new(OAuth::Consumer.new("0Y9NkNE1YQhEmraq0W84bfeXGbTjzwarhQsDxdKM", "ZIG4MzlCtXii8kZ8LlcxMRdCbmxJZV6nIvgOgD3B"))
	end

	def get_ingredients(upc)
		@consumer = api_authentication
     	@response = @consumer.get("http://api.v3.factual.com/t/products-cpg-nutrition?q=#{upc}")
		@data = {}
		if JSON.parse(@response.body)["response"]["data"].first.present?  
            @data["ingredients"]=JSON.parse(@response.body)["response"]["data"].first["ingredients"]
            @data["product_name"]=JSON.parse(@response.body)["response"]["data"].first["product_name"]
            @data["image"]= JSON.parse(@response.body)["response"]["data"].first["image_urls"]	     
            @data   	                
		 else
		 	false
		 end
	end

	def search_product(name)
			@consumer = api_authentication
			n = name.sub("&","")
			url = "http://api.v3.factual.com/t/products-cpg?q=#{n}"
	     	@response = @consumer.get(URI.encode(url))
	        @data = []
			if  JSON.parse(@response.body)["response"].present?
			   @result = JSON.parse(@response.body)["response"]["data"]
			if @result.present?  				
				@result.each do |r|
					product = {}
					product["upc"] = r["upc"]
					product["brand"]= r["brand"]
					product["product_name"] = r["product_name"]
					r["image_urls"].blank? ? product["image"] ='' : product["image"] = r["image_urls"].first
					@data << product
				end
	            @data  
	            else
	            false
	           end 	                
			 else
			 	false
			 end
		end

	def search_by_upc(user,upc)
		@response = get_ingredients(upc)
		@scan_state = ""
		if @response 
			@main_hs = {}
			@members_result=[]
			@unsafe_users = []		
			user.members.each do |m|
				@member = {}
				@member["id"] = m.id
				@member["name"] = m.name
				@matching = ingredients_match_algo(m,@response["ingredients"])
				if @matching == "safe"
				  @member["state"] = "You can eat. Product is safe" 
				elsif @matching == "not ingredients"
				   	@member["state"] = "Ingredients of the product are not available, thats why we are not sure about product"
				    @scan_state = "not sure"
				else 
				   @member["state"] = "Product is not safe."	 
				   @member["harmful_ingredients"]=@matching	
				   @unsafe_users << m.name
				   @scan_state = "not"
				end
				@members_result << @member			    
			end
			@user_result = {}
			@user_result["name"] = user.name
			@match = ingredients_match_algo(user,@response["ingredients"])
			if @match == "safe"
				@user_result["state"]="You can eat." 
			elsif @match == "not ingredients"
				@user_result["state"] = "Ingredients of the product are not available, thats why we are not sure about product"
				@scan_state = "not sure"
			else
			    @user_result["state"]="You can not eat." 
			    @user_result["harmful_ingredients"]=@match
				@unsafe_users << user.name
			    @scan_state = "not"
	        end
	        @main_hs["product"] = @response
	        @main_hs["scan_state"] = @scan_state
	        @main_hs["unsafe_users"] = @unsafe_users
	        @main_hs["user_result"] = @user_result
	        @main_hs["members_result"] = @members_result
	        @main_hs
		 else
		 	  false
		 end
	end

	def ingredients_match_algo(user,ingredients_list)
		@match_ing = [] 
	    if !ingredients_list.blank?
			user.preventives.each do |i|
				if ingredients_list.map(&:downcase).include?(i.name.downcase)
					@match_ing << i.name
				end
			end
			if @match_ing.count > 0
				@match_ing
			else
				return "safe"
			end
		else
			return "not ingredients"
		end
	end
end

class Ingredient < ActiveRecord::Base
	def self.upload_file(file)
	  	CSV.foreach(file.path) do |row|
	    	if row[0].present?
	    		if !Ingredient.exists?(:ingredient_name => row[0].strip)
	    			if Ingredient.create(:ingredient_name => row[0].strip)
	    				p "-----------success-------#{row[0]}"
	    			else
	    				p "xxxxxxxxxxx Failure xxxxxxx #{row[0]}"
	    			end
	    		else
	    			p "======== Already exists ===== #{row[0]}"
	    		end
	    	end
	  	end	  				
    end

end

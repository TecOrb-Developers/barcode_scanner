class PreventivesController < ApplicationController

	def add_preventive
		if params[:user_type].present?
			@user =false
			if params[:user_type] == "user"
			  @user = User.find_by_id(params[:id]) 
			  @msg = "#{params[:name]} preventive added to your profile"
			elsif params[:user_type] == "member"
			  @user = Member.find_by_id(params[:id])
			  @msg = "#{params[:name]} preventive added to #{ @user ? @user.name : '' }"
			end			  	
			if @user
				@preventive = @user.preventives.create(:name => params[:name])
				if @preventive.id != nil
					render :json => {
	                          :response_code => 200,
	                          :response_message => @msg,
	                          :user => @user.as_json(:only=>[:id,:name,:image,:DOB]),
	                          :preventives => @user.preventives.as_json(:only =>[:id,:name])                     
	                          }
	            else
	            	render :json => {
                            :response_code => 500,
                            :response_message => @preventive.errors.messages.map{ |k,v| "#{k.capitalize.to_s.gsub('_',' ')} #{v.first}"}.join(', ')+"."                          
                          }
	            end
			else
			 	render :json => {
		                        :response_code => 500,
		                        :response_message => "user does not exists."                         
		                      }
			end
		else
			render :json => {
		                        :response_code => 500,
		                        :response_message => "Please provide user_type. if current user preventive then user_type 'user' or if add other member preventive then user_type 'member'."                         
		                      }
		end
	end

	def remove_preventive
		@preventive = Preventive.find_by_id(params[:id])
		if @preventive
			@user =false
			if params[:user_type] == "user"
			  @user = User.find_by_id(params[:id]) 
			  @msg = "User does not exists"
			elsif params[:user_type] == "member"
			  @user = Member.find_by_id(params[:id])
			  @msg = "Member does not exists"
			end
			if @user
				@preventive.destroy
				render :json => {
	                            :response_code => 200,
	                            :response_message => "Preventive removed successfully",
	                            :user => @user.as_json(:only=>[:id,:name,:image]),
	                            :preventives => @user.preventives.as_json(:only =>[:id,:name])                     
	                          }
			else
			 	render :json => {
		                        :response_code => 500,
		                        :response_message => @msg                         
		                      }
			end			  	
		else
			render :json => {
		                        :response_code => 500,
		                        :response_message => "preventive does not exists."                         
		                    }
		end
	end
end

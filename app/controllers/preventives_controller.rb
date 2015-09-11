class PreventivesController < ApplicationController
 include ApplicationHelper

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
			if @user and params[:name].present?
			  if Ingredient.where('lower(ingredient_name) = ?', params[:name].downcase.strip).count == 0
				   Ingredient.create(:ingredient_name => params[:name].strip)
			  end
			    if @user.preventives.where('lower(name) = ?', params[:name].downcase.strip).count != 0 
				    @preventive=@user.preventives.where('lower(name) = ?', params[:name].downcase.strip).first 
				    @msg = "#{params[:name]} already added in profile" 
				else
				    @preventive = @user.preventives.create(:name => params[:name].strip) 
				end					
				   if @preventive.id != nil
					   render :json => {
	                          :response_code => 200,
	                          :response_message => @msg,
	                          :user => @user.as_json(:only=>[:id,:name,:image,:dob]),
	                          :preventives =>  @user.preventives.as_json(:only =>[:id,:name])                  
	                          }
	               else
	            	render :json => {
                            :response_code => 500,
                            :response_message => @preventive.errors.messages.map{ |k,v| "#{k.capitalize.to_s.gsub('_',' ')} #{v.first}"}.join(', ')+"."                          
                          }
	            end
			else
			    params[:name].present? ? @m = "User does not exist" : @m = "Please select preventives"			
		         render :json => {
		                        :response_code => 500,
		                        :response_message => @m                         
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
		@preventive = Preventive.find_by_id(params[:preventive_id])
		if @preventive.present?
			@user =false
			if params[:user_type] == "user"
			  @user = User.find_by_id(params[:user_id]) 
			  @msg = "User does not exists"
			elsif params[:user_type] == "member"
			  @user = Member.find_by_id(params[:user_id])
			  @msg = "Member does not exists"
			else
			  @msg = "Please provide user type"
			end
			if @user.present?
				if (@preventive.user_id == params[:user_id] and params[:user_type]=="user") or (@preventive.member_id == params[:user_id] and params[:user_type] == "member")
					@preventive.destroy
					@m ="Preventive removed successfully"
				else
					@m = "Preventive does not belongs to user's profile"
				end
				render :json => {
	                            :response_code => 200,
	                            :response_message => @m,
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

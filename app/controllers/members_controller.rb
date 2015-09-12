class MembersController < ApplicationController

	def add_member
		@user = User.find_by_id(params[:user_id])
		if @user
			@member = @user.members.create(name: params[:name],dob: params[:dob],image: params[:image])
			if @member.id != nil
			  render :json => {
	        	                :response_code => 200,
	        	                :response_message => "Member added successfully."  ,
	        	                :member => @member.as_json(:only=>[:id,:name,:image,:dob])     	               
	        	              }
	        else
	       	 render :json => {
	       	 	                :response_code => 500,
	        	                :response_message => @member.errors.messages.map{ |k,v| "#{k.capitalize.to_s.gsub('_',' ')} #{v.first}"}.join(', ')+"." 
	                        }
			end
		else
			render :json => {
	        	                :response_code => 500,
	        	                :response_message => "User does not exists."        	               
	        	              }
		end
	end

	def manage_profile
		@user = User.find_by_id(params[:user_id])
		if @user
			@member =[]
			@user.members.each do |m|
				@mem={}
				@mem["id"]=m.id
				@mem["name"]=m.name
				@mem["image"]=m.image.url
				@mem["dob"]=m.dob
				@member << @mem
			end
			 render :json => {
	        	                :response_code => 200,
	        	                :response_message => "Member Lists"  ,
	        	                :member => @member    	               
	        	              }
		else
			render :json => {
	        	                :response_code => 500,
	        	                :response_message => "User does not exists."        	               
	        	              }
		end
	end

	def select_member
		@member = Member.find_by_id(params[:member_id])
		if @member
			 render :json => {
	        	                :response_code => 200,
	        	                :response_message => "Member Lists"  ,
	        	                :member => @member.as_json(:only=>[:id,:name,:dob]).merge!(image: @member.image.url),
	        	                :preventives => @member.preventives.as_json(only:[:id,:name])  
	        	                   	               
	        	              }
		else
			render :json => {
	        	                :response_code => 500,
	        	                :response_message => "Member does not exists."        	               
	        	              }
		end
	end

	def edit_member
		@member = Member.find_by_id(params[:member_id])
		if @member
			 @member.name = params[:name] 
			 @member.image = params[:image] if params[:image].present?
			 @member.dob = params[:dob] if params[:dob].present?
			 if @member.save
				 render :json => {
	        	                :response_code => 200,
	        	                :response_message => "Profile updated"
	        	                 }
	       	 else
	       	 	render :json => {
	        	                :response_code => 500,
	        	                :response_message => @member.errors.messages.map{ |k,v| "#{k.capitalize.to_s.gsub('_',' ')} #{v.first}"}.join(', ')+"."         	               
	        	              }
	       	 end

		else
			render :json => {
	        	                :response_code => 500,
	        	                :response_message => "Member does not exists."        	               
	        	              }
		end
	end

	def remove_member
		@user = User.find_by_id(params[:user_id])
	    @member = Member.find_by_id(params[:member_id])
		if @member and @user
			@member.destroy
			render :json => {
	        	                :response_code => 200,
	        	                :response_message => "Member deleted"  ,
	        	                :members => @user.members.as_json(:only=>[:id,:name,:image,:dob])     	               
	        	              }
		else
			render :json => {
	        	                :response_code => 500,
	        	                :response_message => "Member or User does not exists."        	               
	        	              }
		end
	end
 end

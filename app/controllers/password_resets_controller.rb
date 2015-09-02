class PasswordResetsController < ApplicationController

 def forgot_password
   @user = User.find_by_email(params[:email])
    if @user
      @user.send_password_reset  
      render :json => { :Response_code => 200,:Response_message => "Your password reset instrustions has been sent to your email."}  
    else 
      render :json => { :Response_code => 500,:Response_message =>"Email does not exists."}
    end
  end


 def access_code
	@user = User.find_by_password_reset_token(params[:access_code])
  if @user
    if@user.password_reset_token_sent_at < 2.hours.ago
      render :json => { :Response_code => 500,:Response_message => "Your access code has been expired"}	
	  else
	   render :json => { :Response_code => 200,:Response_message => "Your can reset your password now "}	
    end
  else
 	  render :json => { :Response_code => 500,:Response_message => "Please enter valid access code"}	
  end
 end


 def update_password
    @user = User.find_by_id(params[:user_id])
    if @user
      if @user.update_attributes(:password=>params[:password],:password_confirmation=>params[:password_confirmation])
    	   render :json => { :Response_code => 200,
    	  	              :Response_message => "Password has been changed",
                        :user=> @user.as_json(:only=>[:name,:email,:DOB]),
    	  	              }	
      else
         render :json => { :Response_code => 200,
        	                :Response_message => "Somthing worng",
                          :user=>@user.errors.messages.map{ |k,v| "#{k.capitalize.to_s.gsub('_',' ')} #{v.first}"}.join(', ')+"."
        	               }	
      end  
    else
        render :json => { :Response_code => 500,:Response_message => "User does not exists"}  
    end
  end
end 

class PasswordResetsController < ApplicationController



  def forgot_password
      @user = User.find_by_email(params[:email])
        if @user
         @user.send_password_reset  
         render :json => { :response_code => 200,:response_message => "Your password reset instrustions has been sent to your email."}  
       else 
         render :json => { :response_code => 500,:response_message =>"Email does not exists."}
      end
  end


 def access_code
     @user = User.find_by_password_reset_token(params[:access_code])
        if @user
          if@user.password_reset_token_sent_at < 2.hours.ago
            render :json => { :response_code => 500,:response_message => "Your access code has been expired"}	
      	  else
      	   render :json => { :response_code => 200,:response_message => "Your can reset your password now "}	
          end
         else
       	  render :json => { :response_code => 500,:response_message => "Please enter valid access code"}	
        end
      end


 def update_password
      @user = User.find_by_id(params[:user_id])
       if @user
        if @user.update_attributes(:password=>params[:password],:password_confirmation=>params[:password_confirmation])
      	   render :json => { :response_code => 200,
      	  	              :response_message => "Password has been changed",
                          :user=> @user.as_json(:only=>[:name,:email,:dob]),
      	  	              }	
        else
           render :json => { :response_code => 200,
          	                :response_message => "Somthing worng",
                            :user=>@user.errors.messages.map{ |k,v| "#{k.capitalize.to_s.gsub('_',' ')} #{v.first}"}.join(', ')+"."
          	               }	
        end  
      else
          render :json => { :response_code => 500,:response_message => "User does not exists"}  
      end
    end
end 

class SessionsController < ApplicationController
   
   def log_in
   	 user = User.find_by_email(params[:email])
   	 if user
   	  if user.confirmation_token.nil? 
   	   if user.authenticate(params[:password])
         	 render :json => { :Response_code => 200,:Response_message =>"You have successfully logged In !"}
          else
            render :json => { :Response_code => 500,:Response_message =>"Email or password is invalid"}
          end
         else
          render :json => { :Response_code => 500,:Response_message =>"Your account is not verified yet, Please login to your registered email id and visit the link to verify your account."}
        end
       else
         render :json => { :Response_code => 500,:Response_message =>"Authentication failed"}
      end
   end
   
  def log_out
      render :json =>  { :Response_code => 200,:Response_message =>"Successfully logged out."}
  end

  def social_auth
     @user = SocialAuthentication.user_authentication_from_socialmedia(params[:provider_name],params[:uid])
      if @user.present?
       render :json => { :Response_code => 200,:Response_message =>"You have successfully logged In !"}
     else
       render :json => { :Response_code => 500,:Response_message =>"Authentication failed"}
   end
  end
end

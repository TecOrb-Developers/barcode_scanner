class SessionsController < ApplicationController
   
   def log_in
   	 user = User.find_by_email(params[:email])
   	 if user 
     	  if user.confirmation_token.nil? 
          if user.authenticate(params[:password])
         	  render :json => { :Response_code => 200,:Response_message =>"You have successfully logged In"}
          else
            render :json => { :Response_code => 500,:Response_message =>"Email or password is invalid"}
           end
        else
          render :json => { :Response_code => 500,:Response_message =>"Your account is not verified yet, Please login to your registered email id and visit the link to verify your account."}
        end
      else
            render :json => { :Response_code => 500,:Response_message =>"Email does not exist"}
      end
   end
   
   def log_out
      render :json =>  { :Response_code => 200,:Response_message =>"Successfully logged out."}
   end
end

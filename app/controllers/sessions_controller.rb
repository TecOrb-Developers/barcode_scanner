class SessionsController < ApplicationController
   
   def log_in
   	 user = User.find_by_email(params[:email])
      if user 
        if user.confirmation_token.nil? 
          if user.authenticate(params[:password])
            render :json => { :response_code => 200,:user=>user.as_json(:only =>[:id]),:response_message =>"You have successfully logged In"}
          else
            render :json => { :response_code => 500,:response_message =>"Email or password is invalid"}
           end
         else
            render :json => { :response_code => 500,:response_message =>"Your account is not verified yet, Please login to your registered email id and visit the link to verify your account."}
         end
       else
            render :json => { :response_code => 500,:response_message =>"Email does not exist"}
      end
    end
   
  def log_out
      render :json =>  { :response_code => 200,:response_message =>"Successfully logged out."}
  end
end
      
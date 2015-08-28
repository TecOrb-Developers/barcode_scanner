class UsersController < ApplicationController
  def new
  end 

 def sign_up
       @user = User.new(users_params)
        @user.password = params[:password]
        @user.password_confirmation = params[:password_confirmation] 
        if @user.save
         render :json => {
        	                :response_code => 200,
        	                :response_message => "You've signed up successfully.You will receive a verification email "
        	               
        	              }
       else
        render :json => {
        	                :response_code => 500,
        	                :response_message => @user.errors.messages.map{ |k,v| "#{k.capitalize.to_s.gsub('_',' ')} #{v.first}"}.join(', ')+"." 
                        }
    end 	                  
  end	

 def user_confirmation
      @user = User.find_by_confirmation_token(params[:confirmation_token])
      unless @user.blank?
               User.confirm(@user)
               redirect_to new_user_path, :notice =>  "Your account activated successfully, Please go to the app and press login to use the app." 
            else
               redirect_to new_user_path, :notice=> "Your account already Activated, Please go to the app and press login to use the app."
         end
      end
   
  

	private
	def users_params
		params.require(:user).permit(:name,:email,:password,:password_confirmation,:user_type,:DOB)
	end

end

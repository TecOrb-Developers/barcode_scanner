class UsersController < ApplicationController
  def new
  end 

 def sign_up
       @user = User.new(users_params)
        @user.password = params[:password]
        @user.password_confirmation = params[:password_confirmation] 
        if @user.save
         render :json => {
                          :user => @user.as_json(:only=>[:id,:name,:email]),
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
      if @user.present?
               User.confirm(@user)
               redirect_to new_user_path, :notice =>  "Your account activated successfully, Please go to the app and press login to use the app." 
      else
               redirect_to new_user_path, :notice=> "Your account already Activated, Please go to the app and press login to use the app."
      end
 end
   
  def my_profile
    @user = User.find_by_id(params[:user_id])
    if @user
       render :json => {
                            :response_code => 200,
                            :response_message => "Profile fetched"  ,
                            :user => @user.as_json(:only=>[:id,:name,:image,:DOB])                     
                          }
    else
      render :json => {
                            :response_code => 500,
                            :response_message => "user does not exists."                         
                          }
    end
  end

  def edit_profile
    @user = User.find_by_id(params[:user_id])
    if @user
       @user.name = params[:name]
       @user.image = params[:image] if params[:image].present?

       @user.DOB = params[:DOB] if params[:DOB].present?
       if @user.save
         render :json => {
                            :response_code => 200,
                            :response_message => "Profile updated"  ,
                            :user => @user.as_json(:only=>[:id,:name,:image,:DOB])                     
                          }
      else
        render :json => {
                      :response_code => 500,
                      :response_message => @user.errors.messages.map{ |k,v| "#{k.capitalize.to_s.gsub('_',' ')} #{v.first}"}.join(', ')+"."                          
                    }
      end

    else
      render :json => {
                            :response_code => 500,
                            :response_message => "user does not exists."                         
                          }
    end
    
  end

  def scan_history
    @user = User.find(params[:user_id])
    if @user.present? and @user.scan_histories.present?
       @history =@user.scan_histories.where("created_at > ?",Date.today-1.month)  
       render :json => {
                            :response_code => 200,
                            :response_message => "history list fetched successfully" ,
                            :scan_histroy => @history.as_json(:only=>[:user_id,:product_name,:result,:unsafe_users,:created_at])                          
                          }
     
                         
                          
     else
      render :json => {
                            :response_code => 500,
                            :response_message =>"Sorry! No history for this user"                        
                      }    

    end
  end

  def recent_searched_product
      @user = User.find_by_id(params[:user_id])
      @histroy = ScanHistory.order(created_at: :desc)
   if @user.present? and @user.scan_histories.present?
      @scan_histories =@user.scan_histories.first(5)
      render :json => {
                            :response_code => 200,
                            :response_message => "Recently searched product fetched successfully" ,
                            :scan_histroy => @scan_histories.as_json(:only=>[:product_name])                          
                          }
  else
      render :json => {
                            :response_code => 500,
                            :response_message =>"Sorry! User id does not exists"                        
                      }    

    end
 end

 def social_auth
     @user = SocialAuthentication.user_authentication_from_socialmedia(params[:provider_name],params[:uid])
      if @user.present?
       render :json => { :response_code => 200,:user=>@user.as_json(:only=>[:user_id]),:response_message =>"You have successfully logged In !"}
     else
       render :json => { :response_code => 501,:response_message =>"Authentication failed"}
    end
  end


 def authenticate_user
       @user = User.new(users_params)
        @user.password = SecureRandom.urlsafe_base64
        if @user.save
          @user.social_authentications.create(provider_name: params[:provider_name],uid: params[:uid])
         render :json => {
                          :user => @user.as_json(:only=>[:id,:name,:email]),
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
 

	private
	def users_params
		params.require(:user).permit(:name,:email,:password,:password_confirmation,:user_type,:DOB)
	end

end

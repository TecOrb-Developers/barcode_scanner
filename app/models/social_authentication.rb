class SocialAuthentication < ActiveRecord::Base
  belongs_to :user


  def self.user_authentication_from_socialmedia provider,uid
    user = where("uid = ? and provider_name = ?",uid,provider_name)
    if user.present?
      user
    else
      email = "#{uid}@#{provider_name}.com"
      password="12345"
      @newuser = User.create(:email=> email,:password => password,:password_confirmation => password, :name=> "email")
      if @newuser
       user = @newuser.social_authentications.create(:provider_name=> provider_name , :uid => uid)
      else
       false
      end
    end
  end
end

class SocialAuthentication < ActiveRecord::Base
  belongs_to :user

def self.user_authentication_from_socialmedia provider_name,uid
    user = where("provider_name = ? and uid = ?",provider_name,uid)
    if user.present?
      user
    else
      email = "#{uid}@#{provider_name}.com"
      password="12345"
      @newuser = User.create(:email=> email,:password => password,:password_confirmation => password, :name=> "#{uid}")
      if @newuser
       user = @newuser.social_authentications.create(:provider_name=> provider_name , :uid => uid)
      else
       false
      end
    end
  end
end

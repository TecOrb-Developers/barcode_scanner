class SocialAuthentication < ActiveRecord::Base
  belongs_to :user

def self.user_authentication_from_socialmedia provider_name,uid,email
    user = where("provider_name = ? and uid = ? and email = ? ",provider_name,uid,email).first    
    if user.present?
      user.user
    else
      false
    end
  end
end

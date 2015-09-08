class SocialAuthentication < ActiveRecord::Base
  belongs_to :user

def self.user_authentication_from_socialmedia provider_name,uid
    user = where("provider_name = ? and uid = ?",provider_name,uid)
    if user.present?
      user
    else
      false
    end
  end
end

class UserMailer < ApplicationMailer
	default from: "no-reply@ashish.mittal"
	
	def send_confirmation_mail(user)
     @user = user
     mail(:to => user.email, :subject => "Account activation")
  end

  def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => "password reset",:from=>"ashish.mittal")
  end
end

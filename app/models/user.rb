class User < ActiveRecord::Base
 
  has_many :devices, dependent: :destroy
  has_many :social_authentications , dependent: :destroy
  has_many :members , dependent: :destroy
  has_many :preventives , dependent: :destroy
  has_many :ingredients , dependent: :destroy
	validates :name, :presence=>true

	validates :email, :presence=>true,:uniqueness=>true
	
  before_create :generate_token
  after_create :send_confirmation_mail

  has_secure_password
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
    def generate_token   
        self.confirmation_sent_at = Time.zone.now         
        self.confirmation_token = SecureRandom.urlsafe_base64
    end

      
    def send_confirmation_mail  
        UserMailer.send_confirmation_mail(self).deliver 
    end

    def self.confirm(user)
        user.confirmation_token = nil
        user.confirmed_at = Time.now.utc
        if user.save!
          user
        else
         false
        end
      end

    
    def generate_password_token(password_reset_token)        
        self.password_reset_token = SecureRandom.hex(2)
      end          
      
      
   def send_password_reset
        generate_password_token(:password_reset_token)
        self.password_reset_token_sent_at = Time.zone.now
        save!
        UserMailer.password_reset(self).deliver
  end

  def self.get_ingredients upc
     @consumer =  OAuth::AccessToken.new(OAuth::Consumer.new("0Y9NkNE1YQhEmraq0W84bfeXGbTjzwarhQsDxdKM", "ZIG4MzlCtXii8kZ8LlcxMRdCbmxJZV6nIvgOgD3B"))
     @consumer.get("http://api.v3.factual.com/t/products-cpg-nutrition?q=#{upc}")
    end

  def self.get_products name
      @product = OAuth::AccessToken.new(OAuth::Consumer.new("0Y9NkNE1YQhEmraq0W84bfeXGbTjzwarhQsDxdKM", "ZIG4MzlCtXii8kZ8LlcxMRdCbmxJZV6nIvgOgD3B"))
      @product.get("http://api.v3.factual.com/t/products-cpg?q=#{name}")
   end
 end 
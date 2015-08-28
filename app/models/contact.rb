class Contact < ActiveRecord::Base
	validates :name ,:presence => true
	validates :subject ,presence: true
	validates :description ,presence: true
end

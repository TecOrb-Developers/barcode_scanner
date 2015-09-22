class Preventive < ActiveRecord::Base
  belongs_to :user
  belongs_to :member
  validates :name,:presence=>true
end

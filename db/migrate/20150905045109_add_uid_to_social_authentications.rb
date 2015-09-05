class AddUidToSocialAuthentications < ActiveRecord::Migration
  def change
    add_column :social_authentications, :uid, :string
  end
end

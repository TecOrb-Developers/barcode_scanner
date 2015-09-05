class RemoveUidFromSocialAuthentications < ActiveRecord::Migration
  def change
    remove_column :social_authentications, :uid, :integer
  end
end

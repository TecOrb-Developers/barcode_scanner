class CreateSocialAuthentications < ActiveRecord::Migration
  def change
    create_table :social_authentications do |t|
      t.string :provider_name
      t.integer :uid
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

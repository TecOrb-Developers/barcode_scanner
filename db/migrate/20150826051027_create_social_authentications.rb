class CreateSocialAuthentications < ActiveRecord::Migration
  def change
    create_table :social_authentications do |t|
      t.integer :provider_id
      t.string :provider_name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.date   :DOB
      t.string :password_digest
      t.string :user_type
      t.string :confirmation_token
      t.datetime :confirmation_sent_at
      t.datetime :confirmed_at
      t.string :password_reset_token
      t.datetime :password_reset_token_sent_at
      t.datetime :password_confirmed_at
      t.boolean :status
      t.timestamps null: false
    end
  end
end

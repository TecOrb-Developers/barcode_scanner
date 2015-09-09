class AdddobToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dob, :timestamp
  end
end

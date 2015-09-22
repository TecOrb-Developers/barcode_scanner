class AddDobFromUsers < ActiveRecord::Migration
  def change
    add_column :users, :dob, :float
  end
end

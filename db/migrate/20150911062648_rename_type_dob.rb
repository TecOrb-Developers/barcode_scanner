class RenameTypeDob < ActiveRecord::Migration
  def change
  	remove_column :users, :dob ,:timestamp
  	remove_column :members, :dob ,:timestamp
  	add_column :users, :dob, :float
    add_column :members, :dob, :float
  end
end

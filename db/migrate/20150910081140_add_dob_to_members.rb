class AddDobToMembers < ActiveRecord::Migration
  def change
    add_column :members, :dob, :timestamp
  end
end

class RemoveDobFromMembers < ActiveRecord::Migration
  def change
    remove_column :members, :dob, :date
  end
end

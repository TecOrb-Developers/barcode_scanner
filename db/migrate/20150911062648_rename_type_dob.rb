class RenameTypeDob < ActiveRecord::Migration
  def up
    change_column :members, :dob, :datetime
    change_column :users, :dob, :datetime
  end

  def down
    change_column :members, :dob, :timestamp
    change_column :users, :dob, :timestamp    
  end
end

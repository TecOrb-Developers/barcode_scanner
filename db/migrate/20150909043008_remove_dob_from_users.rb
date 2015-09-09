class RemoveDobFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :DOB, :date
  end
end

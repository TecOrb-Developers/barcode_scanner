class CreatePreventives < ActiveRecord::Migration
  def change
    create_table :preventives do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

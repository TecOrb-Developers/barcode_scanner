class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
      t.string :name
      t.string :email
      t.string :image
      t.string :phone
      t.references :restaurant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

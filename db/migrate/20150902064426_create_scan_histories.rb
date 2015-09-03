class CreateScanHistories < ActiveRecord::Migration
  def change
    create_table :scan_histories do |t|
      t.string :product_name
      t.string :result
      t.string :unsafe_users, array: true, default: []
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

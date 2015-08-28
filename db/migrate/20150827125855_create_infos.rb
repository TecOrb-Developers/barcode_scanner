class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :page_name
      t.text :description

      t.timestamps null: false
    end
  end
end

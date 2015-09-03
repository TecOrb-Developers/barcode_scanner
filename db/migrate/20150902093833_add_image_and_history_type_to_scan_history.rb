class AddImageAndHistoryTypeToScanHistory < ActiveRecord::Migration
  def change
    add_column :scan_histories, :image, :string
    add_column :scan_histories, :history_type, :string
  end
end

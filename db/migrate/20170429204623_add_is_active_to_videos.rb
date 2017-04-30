class AddIsActiveToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :is_active, :boolean, default: false
  end
end

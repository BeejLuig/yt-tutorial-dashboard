class AddLockedToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :locked?, :boolean, default: true
  end
end

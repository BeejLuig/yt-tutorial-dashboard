class RemoveLockedFromVideos < ActiveRecord::Migration[5.0]
  def change
    remove_column :videos, :locked?, :boolean
  end
end

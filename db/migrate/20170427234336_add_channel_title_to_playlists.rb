class AddChannelTitleToPlaylists < ActiveRecord::Migration[5.0]
  def change
    add_column :playlists, :channel_title, :string
  end
end

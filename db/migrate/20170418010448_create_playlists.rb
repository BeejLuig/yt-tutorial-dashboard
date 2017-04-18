class CreatePlaylists < ActiveRecord::Migration[5.0]
  def change
    create_table :playlists do |t|
      t.string :title
      t.string :playlist_id
      t.string :description
      t.string :thumbnail_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

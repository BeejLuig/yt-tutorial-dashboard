class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :video_id
      t.string :description
      t.string :thumbnail_url
      t.boolean :complete?, default: false
      t.references :playlist, foreign_key: true

      t.timestamps
    end
  end
end

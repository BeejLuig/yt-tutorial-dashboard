class Video < ApplicationRecord
  belongs_to :playlist
  validates :video_id, :thumbnail_url, :title, presence: true
end

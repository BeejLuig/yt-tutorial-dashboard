class Playlist < ApplicationRecord
  belongs_to :user
  has_many :videos

  validates :title, :playlist_id, :thumbnail_url, presence: true
end

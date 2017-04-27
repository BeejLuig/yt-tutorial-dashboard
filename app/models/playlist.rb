class Playlist < ApplicationRecord
  belongs_to :user

  has_many :videos, dependent: :destroy
  accepts_nested_attributes_for :videos

  validates :title, :playlist_id, :thumbnail_url, :channel_title, presence: true
end

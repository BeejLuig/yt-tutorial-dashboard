class Playlist < ApplicationRecord
  belongs_to :user
  attr_reader :total_videos, :completed_videos

  has_many :videos, dependent: :destroy
  accepts_nested_attributes_for :videos

  validates :title, :playlist_id, :thumbnail_url, :channel_title, presence: true

  def total_videos
    videos.length
  end

  def completed_videos
    videos.select {|v| v.complete? }.length
  end
end

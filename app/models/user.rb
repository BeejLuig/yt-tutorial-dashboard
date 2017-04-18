class User < ApplicationRecord
  has_many :playlists
  has_many :videos, through: :playlists
  has_secure_password

  validates :username, presence: true
end

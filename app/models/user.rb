class User < ApplicationRecord
  has_many :playlists, dependent: :destroy
  has_many :videos, through: :playlists
  has_secure_password

  validates :username, presence: true
end

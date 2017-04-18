require 'rails_helper'

RSpec.describe Playlist, type: :model do
  before(:example) do
    @user = User.create(username: "Test", password: "test")
    @empty_playlist = @user.playlists.create()
    @valid_playlist = @user.playlists.create(
      title: "My Playlist",
      playlist_id: "1293klajdlu299",
      thumbnail_url: "my_image.img"
    )
  end

  it "title can't be empty" do
    @empty_playlist.playlist_id = "1293klajdlu299"
    @empty_playlist.thumbnail_url = "my_image.img"

    expect(@empty_playlist.valid?).to eq(false)
    expect(@valid_playlist.valid?).to eq(true)
  end
  it "playlist_id can't be empty" do
    @empty_playlist.title = "My Playlist"
    @empty_playlist.thumbnail_url = "my_image.img"

    expect(@empty_playlist.valid?).to eq(false)
    expect(@valid_playlist.valid?).to eq(true)
  end
  it "thumbnail_url can't be empty" do
    @empty_playlist.title = "My Playlist"
    @empty_playlist.playlist_id = "1293klajdlu299"
    expect(@empty_playlist.valid?).to eq(false)
    expect(@valid_playlist.valid?).to eq(true)
  end
  it "has_many videos" do
    expect(@valid_playlist.videos.count).to eq(0)
    @valid_playlist.videos.create(
      title: "My New Video",
      thumbnail_url: "vid.img",
      video_id: "alkdf2394"
    )
    expect(@valid_playlist.videos.count).to eq(1)
  end
  it "belongs to a user" do
    expect(@empty_playlist.user_id).to eq(@user.id)
  end
end

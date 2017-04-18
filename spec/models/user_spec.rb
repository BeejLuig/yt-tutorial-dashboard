require 'rails_helper'

RSpec.describe User, type: :model do
  before(:example) do
    @valid_user = User.create(username: "user", password: "password")
    @user_without_username = User.create(username: "", password: "password")
    @user_without_password = User.create(username: "user", password: "")
  end

  it "requires a username" do
    expect(@valid_user.valid?).to eq(true)
    expect(@user_without_username.valid?).to eq(false)
  end

  it "requires a password" do
    expect(@valid_user.valid?).to eq(true)
    expect(@user_without_password.valid?).to eq(false)
  end

  it "has_many Playlists" do
    expect(@valid_user.playlists.count).to eq(0)
    @valid_user.playlists.create(
      title: "My Playlist",
      playlist_id: "1293klajdlu299",
      thumbnail_url: "my_image.img",
    )
    expect(@valid_user.playlists.count).to eq(1)
  end

  it "has_many Videos through Playlists" do
    expect(@valid_user.playlists.count).to eq(0)
    playlist = @valid_user.playlists.create(
      title: "My Playlist",
      playlist_id: "1293klajdlu299",
      thumbnail_url: "my_image.img",
    )
    playlist.videos.create(
      title: "My New Video",
      thumbnail_url: "vid.img",
      video_id: "alkdf2394"
    )
    expect(@valid_user.videos.count).to eq(1)
  end
end

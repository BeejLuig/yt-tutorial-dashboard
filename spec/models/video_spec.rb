require 'rails_helper'

RSpec.describe Video, type: :model do

  before(:example) do
    @user = User.create(username: "Benjamin", password: "Franklin")
    @playlist = @user.playlists.create(
      title: "My Playlist",
      playlist_id: "1293klajdlu299",
      thumbnail_url: "my_image.img"
    )

    @valid_video = @playlist.videos.create(
      title: "My New Video",
      thumbnail_url: "vid.img",
      video_id: "alkdf2394"
    )
    @empty_video = @playlist.videos.create()
  end

  it "complete? defaults to false" do
    expect(@valid_video.complete?).to eq(false)
  end

  it "title can't be empty" do
    @empty_video.video_id = "1293klajdlu299"
    @empty_video.thumbnail_url = "my_image.img"
    expect(@empty_video.valid?).to eq(false)
  end
  it "thumbnail_url can't be empty" do
    @empty_video.title = "My New Video"
    @empty_video.video_id = "1293klajdlu299"
    expect(@empty_video.valid?).to eq(false)
  end
  it "video_id can't be empty" do
    @empty_video.title = "My New Video"
    @empty_video.thumbnail_url = "my_image.img"
    expect(@empty_video.valid?).to eq(false)
  end
end

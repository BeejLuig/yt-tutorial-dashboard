class Api::V1::VideosController < ApplicationController

  def index
    playlist = Playlist.find_by(id: params[:playlist_id])
    @videos = playlist.videos
    render 'videos/videos.json.jbuilder', videos: @videos
  end
end

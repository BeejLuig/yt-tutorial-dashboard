class Api::V1::PlaylistsController < ApplicationController
  before_action :authenticate_token!, only: [:index, :create, :show]

  def index
    @playlists = current_user.playlists
    render 'playlists/playlists.json.jbuilder', playlists: @playlists
  end

  def create
    @playlist = current_user.playlists.new(playlist_params)
    @playlist.videos.each do |video|
      video.playlist = @playlist
    end
    if @playlist.save
      render 'playlists/playlist.json.jbuilder', playlists: @playlist
    else
      render json: {
        errors: @playlist.errors
      }, status: 500
    end
  end

  def show

  end

  private
  def playlist_params
    params.require(:playlist).permit(:title, :playlist_id, :description, :thumbnail_url, videos_attributes: [:title, :video_id, :description, :thumbnail_url])
  end
end

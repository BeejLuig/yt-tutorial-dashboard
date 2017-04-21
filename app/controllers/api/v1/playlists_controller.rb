class Api::V1::PlaylistsController < ApplicationController
  before_action :authenticate_token!, only: [:index, :create, :show]

  def index
    @playlists = current_user.playlists
    render 'playlists/playlists.json.jbuilder', playlists: @playlists
  end

  def create
    @playlist = current_user.playlists.new(
      title: params[:playlist][:title],
      playlist_id: params[:playlist][:playlist_id],
      description: params[:playlist][:description],
      thumbnail_url: params[:playlist][:thumbnail_url]
    )
    if @playlist.save
      render 'playlists/playlist.json.jbuilder', playlists: @playlist
    else

    end
  end

  private
  def playlist_params
    params.require(:playlist).permit(:title, :playlist_id, :description, :thumbnail_url, videos: [])
  end
end

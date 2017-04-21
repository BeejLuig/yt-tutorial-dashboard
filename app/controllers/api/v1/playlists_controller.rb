class Api::V1::PlaylistsController < ApplicationController
  before_action :authenticate_token!, only: [:index, :create, :show]

  def index
    @playlists = current_user.playlists
    render 'playlists/playlists.json.jbuilder', playlists: @playlists
  end

  def create

  end

  private
  def playlist_params
    params.require(:playlist).permit(:title, :playlist_id, :description, :thumbnail_url, videos: [])
  end
end

class Api::V1::PlaylistsController < ApplicationController
  before_action :authenticate_token!, only: [:index, :create, :show]

  def index
    render 'playlists/playlists.json.jbuilder', playlists: current_user.playlists
  end

  def create

  end
end

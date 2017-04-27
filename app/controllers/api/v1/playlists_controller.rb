class Api::V1::PlaylistsController < ApplicationController
  before_action :authenticate_token!

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

  def index
    @playlists = current_user.playlists
    render 'playlists/playlists.json.jbuilder', playlists: @playlists
  end

  def update
    @playlist = Playlist.find_by(id: params[:id])

    if @playlist && @playlist.user == current_user
      if @playlist.update(playlist_params)
        render 'playlists/playlist.json.jbuilder', playlists: @playlist
      else
        render json: {
          errors: @playlist.errors
        }, status: 500
      end
    else
      render json: {
        errors: {
          playlist: ["No playlist found with given id"]
        }, status: 500
      }
    end
  end

  def destroy
    @playlist = Playlist.find_by(id: params[:id])

    if @playlist && @playlist.user == current_user
      @playlist.destroy
      render json: {
        success: ["Playlist successfully deleted"]
      }
    else
      render json: {
        errors: ["Playlist failed to delete"]
      }, status: 500
    end
  end

  def show
    @playlist = Playlist.find_by(id: params[:id])
    if @playlist && @playlist.user == current_user
      render 'playlists/playlist.json.jbuilder', playlists: @playlist
    else
      render json: {
        errors: ["No playlist found with the given id"]
      }, status: 500
    end
  end

  private
  def playlist_params
    params.require(:playlist).permit(:title, :playlist_id, :description, :thumbnail_url, :channel_title, videos_attributes: [:title, :video_id, :description, :thumbnail_url])
  end
end

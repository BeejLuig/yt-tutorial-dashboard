class Api::V1::VideosController < ApplicationController

  def index
    playlist = Playlist.find_by(id: params[:playlist_id])

    if playlist && @videos = playlist.videos
      render 'videos/videos.json.jbuilder', videos: @videos
    else
      render json: {
        errors: {
          videos: ["No videos found with the given playlist id"]
        }
      }
    end
  end

  def reset_videos
    playlist = Playlist.find_by(id: params[:playlist_id])

    if playlist
      @videos = playlist.videos
      @videos.update(complete?: false)
      render 'videos/videos.json.jbuilder', videos: @videos
    else
      render json: {
        errors: {
          videos: ["No videos found with the given playlist id"]
        }
      }
    end
  end

  def complete
    @video = Video.find_by(id: params[:id])
    if @video && !@video.complete?
      @video.update(complete?: true)
      render 'videos/video.json.jbuilder', video: @video
    else
      render json: {
        errors: {
          videos: ["No video found with the given id"]
        }
      }
    end
  end

end

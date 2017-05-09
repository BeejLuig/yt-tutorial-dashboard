class Api::V1::UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      playlist = @user.playlists.create(
        title: "Welcome to YTTD!",
        playlist_id: "PL-aXckYlcnjE5fHYkuEG5NJmf-Aa-4-zw",
        thumbnail_url: "https://i.ytimg.com/vi/uLrFQQ2ysfQ/maxresdefault.jpg",
        description: "Thanks for trying out YouTube Tutorial Dashboard!  Click \"Watch\"  on ths card to get started.",
        channel_title: "Benjamin Cantlupe"
      )
      playlist.videos.create(
        title: "How to add a YouTube playlist to YTTD",
        video_id: "uLrFQQ2ysfQ",
        description: "Thanks for trying out YouTube Tutorial Dashboard! Getting started with YTTD:\n\n1. Find your favorite tutorial channel\n2. Click the playlists tab\n3. Select a playlist\n4. Copy the playlist URL (the end of the URL should include \"list=a-bunch-of-numbers-and-letters\"\n5. Log into YTTD\n6. Paste your URL into the dashboard form and watch the magic happen!\n\nThis project was created for the Flatiron School's Full-Stack web development program. \n\nMore info:\nYTTD web app - https://yttd.herokuapp.com/\nYTTD Source Code - https://github.com/BeejLuig/react-yt-tutorial-dashboard\nYTTD walkthrough - https://goo.gl/bKaFZu",
        thumbnail_url: "https://i.ytimg.com/vi/uLrFQQ2ysfQ/maxresdefault.jpg"

      )
      render 'users/user_with_token.json.jbuilder', user: @user
    else
      render json: {
        errors: @user.errors
      }, status: 500
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end

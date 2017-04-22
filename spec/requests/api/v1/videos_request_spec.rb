require 'rails_helper'

RSpec.describe "Api::V1::Videos", type: :request do

  before(:each) do
    User.destroy_all
    Playlist.destroy_all
    Video.destroy_all

    @user = User.create(
      username: "NewUser",
      password: "password"
    )

    @playlist = @user.playlists.create(title: "title", playlist_id: "abcd123", description: "", thumbnail_url: "this.jpg")

    @playlist.videos.create(title: "title1", video_id: "12345", description: "description1", thumbnail_url: "url1.jpg")
    @playlist.videos.create(title: "title2", video_id: "23456", description: "description2", thumbnail_url: "url2.jpg")

    @token = Auth.create_token(@user.id)
    @token_headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': "Bearer: #{@token}"
    }
    @tokenless_headers = {
      'Content-Type': 'application/json'
    }

  end

  describe "#index" do
    it "on success, shows all videos belonging to a playlist" do
      get "/api/v1/playlists/#{@playlist.id}/videos", headers: @token_headers
      expect(response.body.empty?).to eq(false)
      body = JSON.parse(response.body)
      expect(body.count).to eq(2)
      expect(body.first["title"]).to eq("title1")
      expect(body.first["video_id"]).to eq("12345")
      expect(body.first["description"]).to eq("description1")
      expect(body.first["thumbnail_url"]).to eq("url1.jpg")
      expect(body.first["playlist_id"]).to eq(@playlist.id)
    end

    it "on failure, displays an error message: 'No videos found with the given playlist id'" do
      get "/api/v1/playlists/0/videos", headers: @token_headers
      body = JSON.parse(response.body)
      expect(body).to eq(
        {"errors" => { "videos" => ["No videos found with the given playlist id"] } }
      )
    end
  end

  describe "#reset_videos" do

    before(:each) do
      @playlist = @user.playlists.create(title: "title", playlist_id: "abcd123", description: "", thumbnail_url: "this.jpg")

      @playlist.videos.create(title: "title1", video_id: "12345", description: "description1", thumbnail_url: "url1.jpg", complete?: true)
      @playlist.videos.create(title: "title2", video_id: "23456", description: "description2", thumbnail_url: "url2.jpg", complete?: true)
    end

    it "sets complete? status to false for all videos in the given playlist" do
      @playlist.videos.each do |video|
        expect(video.complete?).to be_truthy
      end

      post "/api/v1/playlists/#{@playlist.id}/reset_videos", headers: @token_headers
      body = JSON.parse(response.body)

      body.each do |video|
        expect(video["complete?"]).to be_falsey
      end
    end

    it "returns the updated array of videos" do

      post "/api/v1/playlists/#{@playlist.id}/reset_videos", headers: @token_headers
      body = JSON.parse(response.body)

      expect(body[0]).to include("title" => "title1")
      expect(body[1]).to include("title" => "title2")
    end
  end

  describe "#complete" do

    it "sets complete? status to true for given video" do
      @video = @playlist.videos.first
      expect(@video.complete?).to be_falsey

      post "/api/v1/videos/#{@video.id}/complete", headers: @token_headers
      body = JSON.parse(response.body)

      expect(body).to include("title1")
      expect(body["complete?"]).to be_truthy
    end
  end
end

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
    pending "it shows all videos belonging to a playlist"
  end
end

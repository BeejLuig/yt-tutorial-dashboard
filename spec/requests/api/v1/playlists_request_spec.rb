require 'rails_helper'

RSpec.describe "Api::V1::Playlists", type: :request do


  before(:each) do
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

  it "requires all routes to have a token" do
    responses = []
    response_bodies = []

    post '/api/v1/playlists', params: { playlist_id: 1 }.to_json, headers: @tokenless_headers
    responses << response
    response_bodies << JSON.parse(response.body)

    get '/api/v1/playlists', headers: @tokenless_headers
    responses << response
    response_bodies << JSON.parse(response.body)

    responses.each { |r| expect(r).have_http_status(403) }
    response_bodies.each { |body| expect(body["errors"]).to eq([{ "message" => "Token is invalid!"}]) }

  end

end

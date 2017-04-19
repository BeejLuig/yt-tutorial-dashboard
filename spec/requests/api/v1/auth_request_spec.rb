require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do

  before(:each) do
    @user = User.create(
      username: "TestUser",
      password: "password"
    )
  end

  describe "POST /auth" do

    describe "on success" do

      before(:each) do
        params = {
          user: {
            username: "TestUser",
            password: "password"
          }
        }

        post "/api/v1/auth",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }

        @response = response
      end

      it "returns the existing user (from params) and a JWT token" do
        body = JSON.parse(response.body)

        expect(@response.status).to eq(200)
        expect(body['token']).not_to eq(nil)
        expect(body['user']['id']).not_to eq(nil)
        expect(body['user']['username']).to eq('TestUser')
        expect(body['user']['password_digest']).to eq(nil)
      end
    end

    describe "on error" do

      before(:each) do
        User.create(
          username: "TestUser",
          password: "password"
        )
      end

      it "unable to find user with email" do
        params = {
          user: {
            username: "BeejLuig",
            password: "password"
          }
        }

        post "/api/v1/auth",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }

          body = JSON.parse(response.body)

          expect(response.status).to eq(500)
          expect(body['errors']).to eq({
            "username"=>["Unable to find a user with the provided username"]
            })
      end

      it "password does not match the provided username" do
        params = {
          user: {
            username: "TestUser",
            password: "password1"
          }
        }

        post "/api/v1/auth",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }

          body = JSON.parse(response.body)

          expect(response.status).to eq(500)
          expect(body['errors']).to eq({
            "password"=>["Password does not match the provided username"]
            })
      end
    end
  end

  describe "POST /auth/refresh" do

    describe "on success" do

      before(:each) do
        token = Auth.create_token(@user.id)

        post "/api/v1/auth/refresh",
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer: #{token}"
          }

        @response = response
      end

      it "returns the existing user (from headers JWT token) and a new JWT token" do
        body = JSON.parse(response.body)

        expect(@response.status).to eq(200)
        expect(body['token']).not_to eq(nil)
        expect(body['user']['id']).not_to eq(nil)
        expect(body['user']['username']).to eq('TestUser')
        expect(body['user']['password_digest']).to eq(nil)
      end
    end
  end
end

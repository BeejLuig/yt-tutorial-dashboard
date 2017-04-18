require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do

  describe "POST /users" do

    describe "on success" do

      it "creates a user from the params" do
        params = {
          user: {
            username: "TestUser",
            password: "password"
          }
        }

        post "/api/v1/users",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }

        body = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(body['token']).not_to eq(nil)
        expect(body['user']['id']).not_to eq(nil)
        expect(body['user']['username']).to eq('TestUser')
        expect(body['user']['password_digest']).to eq(nil)

      end

      it "returns the new user and a JWT token" do

      end
    end

    describe "on error" do

      it "requires a valid username or password" do

      end
    end
  end


end

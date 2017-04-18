class Api::V1::UsersController < ApplicationController

  def create
    token = "1234567890"
    id = 1
    username = params[:user][:username]
    render json: {
      token: token,
      user: {
        id: id,
        username: username
      }
    }
  end
end

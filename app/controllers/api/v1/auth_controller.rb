class Api::V1::AuthController < ApplicationController

  before_action :authenticate_token!, only: [:refresh]

  def login

    @user = User.find_by(username: params[:user][:username])
    if !@user

      render json: {
        errors: ["Unable to find a user with the provided username"]
      }, status: 500

    elsif @user && @user.authenticate(params[:user][:password])
      
      render 'users/user_with_token.json.jbuilder', user: @user

    else
      render json: {
        errors: ["Password does not match the provided username"]
      }, status: 500
    end
  end

  def refresh
    render 'users/user_with_token.json.jbuilder', user: current_user
  end
end

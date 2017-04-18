class Api::V1::UsersController < ApplicationController

  def create
    # 1. create a user
    @user = User.new(user_params)

    if @user.save # -> if creation is successful
      render 'users/user_with_token.json.jbuilder', user: @user
        # 2. pass the user id to an auth module that creates a JWT token
        # 3. we want to return the user boject and the token as json to the client
    else # -> if creation is invalid
      # 2. return the Active Record error messages as json
      # 3. set the status to 500
      render json: {
        errors: @user.errors
      }, status: 500
    end
    # -> if creation is successful
      # 2. pass the user id to an auth module that creates a JWT token
      # 3. we want to return the user boject and the token as json to the client
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end

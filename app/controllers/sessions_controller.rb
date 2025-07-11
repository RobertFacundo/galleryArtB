class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])

      token = JsonWebToken.encode(user_id: user.id)

      render json: {token: token, username: user.username, user_id: user.id}, status: :ok
    else
      render json: { error: "Invalid username or password"}, status: :unauthorized
    end
  end

  def destroy
    render json: { message: "Successfull logOut"}, status: :no_content
  end
end

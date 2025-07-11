class UsersController < ApplicationController
  before_action :authenticate_request!, only: [:me]
  def create
    user = User.new(user_params)

    if user.save
      render json: user.as_json(except: [:password_digest]), status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def me
    render json: @current_user.as_json(except: [:password_digest]), status: :ok
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end

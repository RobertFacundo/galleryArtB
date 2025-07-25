class UsersController < ApplicationController
  before_action :authenticate_request!, only: [:me]
  def create
    user = User.new(user_params)

    if user.save

      token = JsonWebToken.encode(user_id: user.id)

      render json:{
        user: user.as_json(
          only: [:id, :username, :coins, :hasSeenWelcomeModal],
          include: {
            personal_gallery: {
              include: {
                artworks: {
                  except: [:gallery_id, :created_at, :updated_at]
                }
              },
              except: [:user_id, :created_at, :updated_at]
            }
          }
        ),
        token: token
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def me
    render json: @current_user.as_json(
      only: [:id, :username, :coins, :hasSeenWelcomeModal],
      include: {
        personal_gallery: {
          include: {
            artworks: {
              except: [:gallery_id, :created_at, :updated_at]
            }
          },
          except: [:user_id, :created_at, :updated_at]
        }
      }
    ), status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end

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
    user_json = @current_user.as_json(
      only: [:id, :username, :coins, :hasSeenWelcomeModal]
    )

    if @current_user.personal_gallery.present?
      personal_gallery_json = @current_user.personal_gallery.as_json(
        except: [:user_id, :created_at, :updated_at]
      )

      transformed_artworks = @current_user.personal_gallery.artworks.map do |artwork|
        artwork.as_json(except: [:gallery_id, :created_at, :updated_at], base_url: request.base_url)
      end

      personal_gallery_json[:artworks] = transformed_artworks
      user_json[:personal_gallery] = personal_gallery_json
    else
      user_json[:personal_gallery] = nil
    end

    render json: user_json, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end

class UserGalleriesController < ApplicationController
    before_action :authenticate_request!

    def add_artwork
      artwork = Artwork.find_by(id: params[:artwork_id])
      unless artwork
        render json: { error: "Artwork not found" }, status: :not_found and return
      end

      personal_gallery = @current_user.personal_gallery || @current_user.galleries.find_or_create_by(name: 'My Personal Gallery')

      if personal_gallery.artworks.include?(artwork)
        render json: { error: 'Artwork already in your gallery' }, status: :conflict and return
      end

      unless @current_user.coins >= artwork.price
        render json: { error: "Not enough coins to purchase this artwork" }, status: :unprocessable_entity and return
      end

      ActiveRecord::Base.transaction do
        @current_user.coins -= artwork.price
        @current_user.save!
        
        personal_gallery.artworks << artwork
        personal_gallery.save!
      end

      @current_user.reload

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
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end

    def show
      personal_gallery = @current_user.personal_gallery || @current_user.galleries.find_by(name: 'My Personal Gallery')

      unless personal_gallery
        render json: { message: "Personal gallery not foundfor this user" }, status: :not_found and return
      end

      transformed_artworks = personal_gallery.artworks.map do |artwork|
        artwork_json = artwork.as_json(except: [:gallery_id, :created_at, :updated_at])

        if artwork.image_url.present?
          artwork_json[:image_url] = "#{request.base_url}/#{artwork.image_url}"
        else
          artwork_json[:image_url] = nil
        end
        artwork_json
      end

      gallery_json = personal_gallery.as_json(except: [:user_id, :created_at, :updated_at])
      gallery_json[:artworks] = transformed_artworks

      render json: gallery_json, status: :ok
    end
end

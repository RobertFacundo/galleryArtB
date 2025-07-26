class ArtworksController < ApplicationController
  def index
    default_gallery = Gallery.find_by(name: 'Work collections')

    if default_gallery
      artworks = default_gallery.artworks.order(created_at: :desc)

      rendered_artworks = artworks.map do |artwork|
        artwork_json = artwork.as_json(except: [:gallery_id, :created_at, :updated_at])

        if artwork.image_url.present?
          artwork_json[:image_url] = "#{request.base_url}/art_images/#{artwork.image_url}"
        else
          artwork_json[:image_url] = nil
        end 

      artwork_json
      end

      render json: rendered_artworks, status: :ok
    else
      render json: { message: 'Work collection not found'}, status: :not_found
    end
  end
end

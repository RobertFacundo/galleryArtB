class ArtworksController < ApplicationController
  def index
    default_gallery = Gallery.find_by(name: 'Work collections')

    if default_gallery
      artworks = default_gallery.artworks.order(created_at: :desc)

      rendered_artworks = artworks.map do |artwork|
        artwork.as_json(except: [:gallery_id, :created_at, :updated_at], base_url: request.base_url)
      end

      render json: rendered_artworks, status: :ok
    else
      render json: { message: 'Work collection not found'}, status: :not_found
    end
  end
end

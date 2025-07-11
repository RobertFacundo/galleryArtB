class ArtworksController < ApplicationController
  def index
    default_gallery = Gallery.find_by(name: 'Work collections')

    if default_gallery
      artworks = default_gallery.artworks.order(created_at: :desc)
      render json: artworks.as_json(except: [:gallery_id, :created_at, :updated_at]), status: :ok
    else
      render json: { message: 'Work collection not found'}, status: :not_found
    end
  end
end

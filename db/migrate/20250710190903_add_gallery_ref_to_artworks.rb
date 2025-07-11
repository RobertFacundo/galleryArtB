class AddGalleryRefToArtworks < ActiveRecord::Migration[8.0]
  def change
    add_reference :artworks, :gallery, null: false, foreign_key: true
  end
end

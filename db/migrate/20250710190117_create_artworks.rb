class CreateArtworks < ActiveRecord::Migration[8.0]
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :artist_name
      t.text :description
      t.string :image_url
      t.decimal :price
      t.string :category

      t.timestamps
    end
  end
end

puts "--- Cleaning DataBase---"
Artwork.destroy_all
Gallery.destroy_all
User.destroy_all
puts "Clean database"

puts "--- Creating example user---"
admin_user = User.find_or_create_by!(username: 'admin_user') do |u|
    u.password = 'password123'
    u.password_confirmation = 'password123'
    u.hasSeenWelcomeModal = true
    u.coins = 100
end
puts 'User found (ID: #{admin_user.id})'

puts "--- Creating default gallery---"
default_gallery = Gallery.find_or_create_by!(name: 'Work collections') do |g|
  g.user = admin_user
end
puts "Galería 'Obras de Colección' creada/encontrada (ID: #{default_gallery.id}) para #{admin_user.username}."

puts '---Creating works of art'

artworks_data =[
  {
    title: "La Noche Estrellada",
    artist_name: "Vincent van Gogh",
    description: "Una pintura al óleo sobre lienzo del artista postimpresionista holandés Vincent van Gogh. Representa la vista desde la ventana orientada al este de su habitación en el sanatorio de Saint-Paul-de-Mausole, justo antes del amanecer, con la adición de un pueblo idealizado.",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1280px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg",
    price: 5.50, # Ejemplo de precio entre 3 y 6
    category: "Pintura"
  },
  {
    title: "El Pensador",
    artist_name: "Auguste Rodin",
    description: "Una de las esculturas más famosas de Auguste Rodin, que representa a una figura masculina desnuda sentada en una roca, absorto en una profunda meditación. Originalmente parte de una obra mayor, 'Las Puertas del Infierno'.",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/The_Thinker_by_Auguste_Rodin_-_IMG_7138.JPG/800px-The_Thinker_by_Auguste_Rodin_-_IMG_7138.JPG",
    price: 4.75, # Ejemplo de precio entre 3 y 6
    category: "Escultura"
  },
]

artworks_data.each_with_index do |data, index|
  Artwork.create!(
    title: data[:title],
    artist_name: data[:artist_name],
    description: data[:description],
    image_url: data[:image_url],
    price: data[:price],
    category: data[:category],
    gallery: default_gallery
  )
  puts " - Created: #{data[:title]} (Category: #{data[:category]})"
end

puts "--- Seeds successfully completed"

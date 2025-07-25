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
    title: "The Starry Night",
    artist_name: "Vincent van Gogh",
    description: "An oil on canvas painting from 1889, depicting the view from a sanatorium window, with a turbulent night sky and a towering cypress tree.",
    image_url: "/art_images/1.jpg",
    price: 5.50,
    category: "Painting"
  },
  {
    title: "Mona Lisa",
    artist_name: "Leonardo da Vinci",
    description: "The iconic Renaissance portrait, famous for its enigmatic smile. Oil on poplar panel.",
    image_url: "/art_images/2.jpg",
    price: 6.00,
    category: "Painting"
  },
  {
    title: "The Creation of Adam",
    artist_name: "Michelangelo",
    description: "A fresco painting forming part of the Sistine Chapel's ceiling, illustrating the biblical narrative where God gives life to Adam.",
    image_url: "/art_images/3.jpg",
    price: 5.80,
    category: "Painting"
  },
  {
    title: "The Scream",
    artist_name: "Edvard Munch",
    description: "An expressionist artwork depicting an anguished figure against a blood-red sky, symbolizing universal human anxiety.",
    image_url: "/art_images/4.jpg",
    price: 5.25,
    category: "Painting"
  },
  {
    title: "Guernica",
    artist_name: "Pablo Picasso",
    description: "A vast oil mural depicting the suffering of people and animals caused by the violence and chaos of war.",
    image_url: "/art_images/5.jpg",
    price: 5.90,
    category: "Painting"
  },
   {
    title: "The Persistence of Memory",
    artist_name: "Salvador Dalí",
    description: "Iconic surrealist painting featuring melting soft watches in a desolate landscape, exploring the relativity of time and dreams.",
    image_url: "/art_images/6.jpg",
    price: 4.80,
    category: "Painting"
  },
  {
    title: "The Kiss",
    artist_name: "Gustav Klimt",
    description: "An oil painting with gold and silver leaf depicting a couple embracing, enveloped in a golden, ornate cloak.",
    image_url: "/art_images/7.webp",
    price: 5.60,
    category: "Painting"
  },
  {
    title: "Girl with a Pearl Earring",
    artist_name: "Johannes Vermeer",
    description: "A Dutch tronie of a young woman with an exotic turban and a large pearl earring, often called the 'Mona Lisa of the North'.",
    image_url: "/art_images/8.jpg",
    price: 4.95,
    category: "Painting"
  },
  {
    title: "Las Meninas",
    artist_name: "Diego Velázquez",
    description: "A masterpiece of the Spanish Golden Age, a complex portrait of the royal family with the artist himself depicted within the canvas.",
    image_url: "/art_images/9.jpg",
    price: 5.75,
    category: "Painting"
  },
  {
    title: "The Night Watch",
    artist_name: "Rembrandt van Rijn",
    description: "A large oil on canvas painting depicting a civic militia company, renowned for its dramatic use of light and shadow.",
    image_url: "/art_images/10.jpg",
    price: 5.40,
    category: "Painting"
  },
  {
    title: "Wheatfield with Cypresses",
    artist_name: "Vincent van Gogh",
    description: "An oil landscape capturing dark, swirling cypresses under a vibrant sky, characteristic of Van Gogh's Post-Impressionist style.",
    image_url: "/art_images/11.jpg",
    price: 5.10,
    category: "Painting"
  },
   {
    title: "American Gothic",
    artist_name: "Grant Wood",
    description: "A 1930 painting depicting a stern-faced farmer and a woman (his daughter), standing in front of a white house with a Gothic window.",
    image_url: "/art_images/12.jpg",
    price: 4.60,
    category: "Painting"
  },
  {
    title: "The Birth of Venus",
    artist_name: "Sandro Botticelli",
    description: "A large tempera painting depicting the goddess Venus emerging from the sea, a masterpiece of the early Renaissance.",
    image_url: "/art_images/13.jpg",
    price: 5.30,
    category: "Painting"
  },
  {
    title: "Impression, Sunrise",
    artist_name: "Claude Monet",
    description: "The painting that gave Impressionism its name, depicting a sunrise over the harbor of Le Havre, France.",
    image_url: "/art_images/14.jpg",
    price: 5.00,
    category: "Painting"
  },
  {
    title: "Whistler's Mother",
    artist_name: "James McNeill Whistler",
    description: "Also known as 'Arrangement in Grey and Black No. 1', it's a famous oil painting of Whistler's mother, Anna McNeill Whistler.",
    image_url: "/art_images/15.jpg",
    price: 4.70,
    category: "Painting"
  },
  {
    title: "A Sunday Afternoon on the Island of La Grande Jatte",
    artist_name: "Georges Seurat",
    description: "A monumental example of pointillism, depicting Parisians at leisure on a river island, composed of millions of tiny dots of paint.",
    image_url: "/art_images/16.jpg",
    price: 5.85,
    category: "Painting"
  },
  {
    title: "The Last Supper",
    artist_name: "Leonardo da Vinci",
    description: "A mural painting depicting the final meal of Jesus with his apostles, a highly influential work of the High Renaissance.",
    image_url: "/art_images/17.jpg",
    price: 5.95,
    category: "Painting"
  },
  {
    title: "Composition with Red, Blue, and Yellow",
    artist_name: "Piet Mondrian",
    description: "A definitive work of abstract art, using a grid of black lines and blocks of primary colors (red, blue, yellow) on white.",
    image_url: "/art_images/18.jpg",
    price: 4.20,
    category: "Painting"
  },
  {
    title: "The Great Wave off Kanagawa",
    artist_name: "Katsushika Hokusai",
    description: "A famous woodblock print depicting a colossal wave threatening three boats with Mount Fuji in the background. Technically a print, but often considered a 'painting' in common parlance.",
    image_url: "/art_images/19.jpg",
    price: 4.50,
    category: "Painting"
  },
  {
    title: "Water Lilies",
    artist_name: "Claude Monet",
    description: "Part of a series of approximately 250 oil paintings depicting his flower garden at Giverny, capturing the changing light and reflections on water.",
    image_url: "/art_images/20.jpg",
    price: 5.70,
    category: "Painting"
  },
  {
    title: "The Thinker",
    artist_name: "Auguste Rodin",
    description: "A bronze sculpture depicting a nude male figure seated on a rock, deeply absorbed in thought. Originally part of Rodin's 'The Gates of Hell'.",
    image_url: "/art_images/21.jpg",
    price: 4.75,
    category: "Sculpture"
  },
  {
    title: "David",
    artist_name: "Michelangelo",
    description: "A Renaissance masterpiece, a 5.17-meter (17.0 ft) marble statue of the biblical hero David, depicted before his battle with Goliath.",
    image_url: "/art_images/22.jpg",
    price: 5.90,
    category: "Sculpture"
  },
  {
    title: "Venus de Milo",
    artist_name: "Alexandros of Antioch (attributed)",
    description: "An ancient Greek marble statue depicting Aphrodite, famous for its classical beauty and the loss of its arms.",
    image_url: "/art_images/23.jpg",
    price: 5.15,
    category: "Sculpture"
  },
  {
    title: "Discobolus",
    artist_name: "Myron (original, Roman copy pictured)",
    description: "A classical Greek sculpture depicting an athlete poised to throw a discus, renowned for its dynamic composition and anatomical precision.",
    image_url: "/art_images/24.JPG",
    price: 4.20,
    category: "Sculpture"
  },
   {
    title: "Winged Victory of Samothrace",
    artist_name: "Anonymous (Hellenistic period)",
    description: "A majestic marble statue of the Greek goddess Nike (Victory), with outstretched wings, appearing to land on a ship's prow.",
    image_url: "/art_images/25.jpg",
    price: 5.65,
    category: "Sculpture"
  },
  {
    title: "Pietà",
    artist_name: "Michelangelo",
    description: "A masterpiece of Renaissance sculpture, depicting the Virgin Mary cradling the dead body of Jesus after his crucifixion.",
    image_url: "/art_images/26.jpg",
    price: 5.85,
    category: "Sculpture"
  },
  {
    title: "Statue of Liberty",
    artist_name: "Frédéric Auguste Bartholdi",
    description: "A colossal neoclassical sculpture on Liberty Island in New York Harbor, a gift from France to the United States.",
    image_url: "/art_images/27.webp",
    price: 5.30,
    category: "Sculpture"
  },
   {
    title: "Manneken Pis",
    artist_name: "Jérôme Duquesnoy the Elder",
    description: "A landmark small bronze sculpture in Brussels, Belgium, depicting a naked little boy urinating into a fountain basin.",
    image_url: "/art_images/28.jpg",
    price: 3.50,
    category: "Sculpture"
  },
   {
    title: "Christ the Redeemer",
    artist_name: "Paul Landowski",
    description: "A colossal Art Deco statue of Jesus Christ in Rio de Janeiro, Brazil, overlooking the city from Corcovado mountain.",
    image_url: "/art_images/29.jpg",
    price: 5.99,
    category: "Sculpture"
  },
  {
    title: "Ecstasy of Saint Teresa",
    artist_name: "Gian Lorenzo Bernini",
    description: "A central sculptural group in white marble set in an aedicule of polychrome marble, depicting Teresa of Ávila in religious ecstasy.",
    image_url: "/art_images/30.jpg",
    price: 5.45,
    category: "Sculpture"
  },
  {
    title: "Apollo and Daphne",
    artist_name: "Gian Lorenzo Bernini",
    description: "A life-sized baroque marble sculpture depicting the climax of the story of Apollo and Daphne in Greek mythology.",
    image_url: "/art_images/31.jpg",
    price: 5.70,
    category: "Sculpture"
  },
   {
    title: "The Kiss (Le Baiser)",
    artist_name: "Auguste Rodin",
    description: "A marble sculpture depicting a nude couple embracing, symbolizing eternal love, originally part of 'The Gates of Hell'.",
    image_url: "/art_images/32.jpg",
    price: 5.60,
    category: "Sculpture"
  },
  {
    title: "Laocoön and His Sons",
    artist_name: "Agesander, Athenodoros and Polydorus of Rhodes",
    description: "A monumental marble sculpture depicting the Trojan priest Laocoön and his sons being attacked by sea serpents.",
    image_url: "/art_images/33.jpg",
    price: 5.20,
    category: "Sculpture"
  },
   {
    title: "Moai (from Easter Island)",
    artist_name: "Rapa Nui people",
    description: "Monolithic human figures carved by the Rapa Nui people on Easter Island, representing deified ancestors.",
    image_url: "/art_images/34u.jpg",
    price: 3.80,
    category: "Sculpture"
  },
  {
    title: "Bronze Head",
    artist_name: "Henry Moore",
    description: "An abstract bronze sculpture showcasing the artist's focus on organic forms and the human figure in a monumental way.",
    image_url: "/art_images/35.webp",
    price: 4.10,
    category: "Sculpture"
  },
  {
    title: "Spider (Maman)",
    artist_name: "Louise Bourgeois",
    description: "A massive steel and marble sculpture of a spider, serving as a powerful and ambiguous symbol of motherhood.",
    image_url: "/art_images/36.jpg",
    price: 5.55,
    category: "Sculpture"
  },
   {
    title: "Cloud Gate",
    artist_name: "Anish Kapoor",
    description: "A public sculpture in Millennium Park, Chicago, nicknamed 'The Bean' for its bean-like shape, reflecting the city skyline.",
    image_url: "/art_images/37.jpg",
    price: 5.35,
    category: "Sculpture"
  },
  {
    title: "Column of Trajan",
    artist_name: "Apollodorus of Damascus (attributed)",
    description: "A Roman triumphal column in Rome, commemorating Emperor Trajan's victory in the Dacian Wars, featuring a spiral bas-relief.",
    image_url: "/art_images/38.jpg",
    price: 5.05,
    category: "Sculpture"
  }
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

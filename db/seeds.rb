# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

comments = [
  "Le cours était très informatif et bien structuré.",
  "J'ai apprécié la clarté de l'instructeur et la qualité des matériaux fournis.",
  "Les leçons étaient engageantes et faciles à suivre.",
  "Ce cours a fourni un excellent aperçu et était très complet.",
  "J'ai trouvé le rythme parfait et les explications claires.",
  "Les devoirs étaient stimulants mais gratifiants.",
  "Dans l'ensemble, une expérience très enrichissante et éducative.",
  "Le soutien de l'instructeur était excellent tout au long du cours.",
  "Je recommanderais fortement ce cours à d'autres.",
  "Le contenu était bien organisé et facile à comprendre.",
  "Je me sens beaucoup plus confiant dans ce sujet après avoir terminé le cours.",
  "Les éléments interactifs ont aidé à renforcer l'apprentissage.",
  "Les exemples utilisés dans les leçons étaient très utiles.",
  "Ce cours a dépassé mes attentes.",
  "J'ai apprécié la flexibilité de la structure du cours."
]

titles = [
  "Excellente expérience d'apprentissage",
  "Très bon cours",
  "Très informatif",
  "Excellent cours dans l'ensemble",
  "Leçons bien structurées",
  "Engageant et perspicace",
  "Complet et clair",
  "Enseignement exceptionnel",
  "Approfondi et détaillé",
  "Pratique et utile",
  "Voyage éclairant",
  "Connaissances précieuses acquises",
  "Cours de premier ordre",
  "Programme impressionnant",
  "Enseignement exceptionnel"
]

# Clear existing data
Message.destroy_all
Chatroom.destroy_all
Review.destroy_all
Booking.destroy_all
Skill.destroy_all
User.destroy_all

puts "Creating user test"

mattieu_user = User.create!(
  email: 'mattieu@example.com',
  password: 'password',
  first_name: 'Mattieu',
  last_name: 'Yves',
  age: 23,
  genre: 'Homme',
  bio: "Salut ! Je m'appelle Mattieu, j'ai appris la Photographie auprès de mon grand-père et depuis je n'ai plus arrêté. Transmettre cet héritage est mon plus grand plaisir ! Récemment j'ai entendu Mistral Gagnant et j'ai A-DO-RÉ ! J'ai vraiment envie d'apprendre à le jouer au piano.",
  address: "2 Rue du Faubourg du Temple, 75010 Paris",
  city: 'Paris',
  area: 1,
  token: 5,
  latitude: 48.867742,
  longitude: 2.3647827
)
jean_user = User.create!(
  email: 'jean@example.com',
  password: 'password',
  first_name: 'Jean',
  last_name: 'Motte',
  age: 26,
  genre: 'Homme',
  bio: "Bonjour moi c'est Jeanot ! Passioné de piano depuis mon enfance, j'aime transmettre ma passion. Je suis également très curieux et souhaite acquérir des compétences en Photographie.",
  address: "11-3 Rue Jean-Baptiste Dumay, 75020 Paris",
  city: 'Paris',
  area: 1,
  token: 5,
  latitude: 48.8738989,
  longitude: 2.3879974
)

file = URI.open("https://res.cloudinary.com/dev8n3mm2/image/upload/v1718269883/portrait_mattieu_jxfkdi.jpg")
mattieu_user.photo.attach(io: file, filename: "#{mattieu_user.first_name}.jpg", content_type: "image/jpeg")
mattieu_user.save!

file = URI.open("https://res.cloudinary.com/dev8n3mm2/image/upload/v1718269883/portrait_jean_pnjfan.jpg")
jean_user.photo.attach(io: file, filename: "#{jean_user.first_name}.jpg", content_type: "image/jpeg")
jean_user.save!

goal = ["découverte", "passion", "reconversion"]
# name = ["poterie", "menuiserie", "dessin", "guitare", "running", "chinois"]

puts "creating skill for test_user"

activites_avec_icones = {
  "Sport" => {
      "icon" => "⚽️",
      "activities" => ["Football", "Basketball", "Natation", "Piano"]
  },
  "Cuisine" => {
      "icon" => "🍽️",
      "activities" => ["Pâtisserie", "Cuisine italienne", "Grillades", "Piano"]
  },
  "Musique" => {
      "icon" => "🎵",
      "activities" => ["Piano"]
  },
  "Lecture" => {
      "icon" => "📚",
      "activities" => ["Romans", "Poésie", "Biographies", "Essais philosophiques"]
  },
  "Voyage" => {
      "icon" => "✈️",
      "activities" => ["Randonnée", "Visites culturelles", "Camping", "Piano"]
  },
  "Art" => {
      "icon" => "🎨",
      "activities" => ["Peinture", "Sculpture", "Photographie", "Dessin"]
  },
  "Technologie" => {
      "icon" => "💻",
      "activities" => ["Programmation", "Robotique", "Impression 3D", "Piano"]
  },
  "Jardinage" => {
      "icon" => "🌱",
      "activities" => ["Plantes d'intérieur", "Potager", "Paysagisme", "Piano"]
  },
  "Loisirs créatifs" => {
      "icon" => "✂️",
      "activities" => ["Tricot", "Scrapbooking", "Couture", "Piano"]
  },
  "Bien-être" => {
      "icon" => "🧘",
      "activities" => ["Yoga", "Méditation", "Aromathérapie", "Spa"]
  }
}

# categorie_aleatoire = activites_avec_icones.keys.sample
# activite_aleatoire = activites_avec_icones[categorie_aleatoire]["activities"].sample
Skill.create!(
  category: "Art",
  name: "Photographie",
  goal: goal.sample,
  experience_year: rand(1..20),
  user: mattieu_user,
  icon: "🎨"
)

# categorie_aleatoire = activites_avec_icones.keys.sample
# activite_aleatoire = activites_avec_icones[categorie_aleatoire]["activities"].sample
Skill.create!(
  category: "Musique",
  name: "Piano",
  goal: goal.sample,
  experience_year: rand(1..20),
  user: jean_user,
  icon: "🎵"
)


  user_img= %w[
    https://images.unsplash.com/photo-1528892952291-009c663ce843?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzR8fHBvcnRyYWl0fGVufDB8fDB8fHww
    https://images.unsplash.com/photo-1521119989659-a83eee488004?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHBvcnRyYWl0fGVufDB8fDB8fHww
    https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Njd8fHBvcnRyYWl0fGVufDB8fDB8fHww
    https://images.unsplash.com/photo-1542327897-d73f4005b533?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzJ8fHBvcnRyYWl0fGVufDB8fDB8fHww
    https://images.unsplash.com/photo-1548810020-ea2f1da35cff?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTgzfHxwb3J0cmFpdHxlbnwwfHwwfHx8MA%3D%3D
    https://images.unsplash.com/photo-1592621385645-e41659e8aabe?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTg3fHxwb3J0cmFpdHxlbnwwfHwwfHx8MA%3D%3D
    https://images.unsplash.com/photo-1502785424245-21e9ffc8f93f?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjIzfHxwb3J0cmFpdHxlbnwwfHwwfHx8MA%3D%3D
  ]




# Create 10 Users
addresses = [
  { address: '52 Avenue des Champs-Elysees, Paris', latitude: 48.8706807, longitude: 2.3062104 },
  { address: '17 Passage Duhesme, Paris', latitude: 48.8959605, longitude: 2.3480738 },
  { address: '2 Impasse Delaunay, Paris', latitude: 48.8551397, longitude: 2.3860662 },
  { address: '61 Rue Bichat, Paris', latitude: 48.8732908, longitude: 2.3654808 },
  { address: '39 Rue de Babylone, Paris', latitude: 48.8516502, longitude: 2.3193309 },
  { address: '6 Rue Barthélemy, Paris', latitude: 48.8460169, longitude: 2.310151 },
  { address: '57 Rue Marguerite de Rochechouart, Paris', latitude: 48.880022804275406, longitude: 2.3459845964142336 },
  { address: '66 Rue La Fayette, Paris', latitude: 48.87567730172532, longitude: 2.3439229201617686 },
  { address: "35 Rue du Château d'Eau, Paris", latitude: 48.871481286314314, longitude: 2.3579723852199304 },
  { address: '42 Bd Saint-Marcel, Paris', latitude: 48.83894388173651, longitude: 2.3571411819688897 },
  { address: '40-50 Rue Lecourbe, Paris', latitude: 48.844266, longitude: 2.307857 },
  { address: '29-17 Rue Viala, Paris', latitude: 48.850269, longitude: 2.289599 },
  { address: '80 Rue de la Croix Nivert, Paris', latitude: 48.84426530019471, longitude: 2.2960210387408857 },
  { address: '84 Rue Saint-Dominique, Paris', latitude: 48.85986005019866, longitude: 2.3066979430601875 },
  { address: '51-53 Rue Cambon, Paris', latitude: 48.86965304307112, longitude: 2.327831738742462 },
  { address: '2 Pass. Cardinet, Paris', latitude: 48.88556151761359, longitude: 2.310439512528376 },
  { address: '30 Rue de Mouzaïa, Paris', latitude: 48.88020420304117, longitude: 2.3938558066809534 },
  { address: '3 Rue de Romainville, Paris', latitude: 48.875939527756216, longitude: 2.399218132698809 },
  { address: '1 Rue Raoul Dufy, Paris', latitude: 48.86537586479889, longitude: 2.390859399752756 },
  { address: '109 Bd des Filles du Calvaire, Paris', latitude: 48.86062694427487, longitude: 2.367076017543853 },
  { address: '18 Rue de Ménilmontant, Paris', latitude: 48.867515635561524, longitude: 2.3847577234001336 },
  { address: '110 Av. Ledru Rollin, Paris', latitude: 48.852673498476776, longitude: 2.3770034178277495 },
]

  user = 50.times.map do |i|
    address = addresses.sample

    user = User.create!(
      email: Faker::Internet.unique.email,
      password: 'password',
      genre: ['Homme', 'Femme'].sample,
      first_name: "test",
      last_name: Faker::Name.last_name,
      age: rand(18..65),
      bio: "test",
      city: Faker::Address.city,
      area: rand(1..10),
      token: rand(1..5),
      address: address[:address],
      latitude: address[:latitude],
      longitude: address[:longitude],
    )

    user.update(first_name: user.genre == 'Homme' ? Faker::Name.male_first_name : Faker::Name.female_first_name)

    # file = URI.open(user_img[i])
    if user.genre == 'Femme'
      file = URI.open("https://xsgames.co/randomusers/avatar.php?g=female")
    else
      file = URI.open("https://xsgames.co/randomusers/avatar.php?g=male")
    end
    user.photo.attach(io: file, filename: "#{user.first_name}.jpg", content_type: "image/jpeg")
    user.save!

    categorie_aleatoire = activites_avec_icones.keys.sample
    activite_aleatoire = activites_avec_icones[categorie_aleatoire]["activities"].sample
    Skill.create!(
      category: categorie_aleatoire,
      name: activite_aleatoire,
      goal: goal.sample,
      experience_year: rand(1..20),
      user: user,
      icon: activites_avec_icones[categorie_aleatoire]["icon"]
    )
  end

puts "creating users and their skills"

# Create 10 Bookings

puts "creating bookings (et par extension les chatrooms)"

60.times.map do
    skill = Skill.all.sample
    user = User.all.sample
    booking = Booking.create!(
      duration: rand(1..4),
      token_cost: 1,
      session_format: ['Distance', 'Physique'].sample,
      skill: skill,
      user: user,
      start_date: Faker::Date.between(from: 1.year.ago, to: 1.year.from_now),
      end_date: Faker::Date.between(from: 1.year.from_now, to: 2.year.from_now),
      content: Faker::Lorem.paragraph,
      status: %w[pending confirmed rejected].sample
    )
    Review.create!(
      rating: rand(1..5),
      comment: comments.sample,
      title: titles.sample,
      booking: booking,
      user: User.all.sample
    )
end

# Create 10 Messages
User.where.not(id: [mattieu_user.id, jean_user.id]).each do |user|
  bio = "Bonjour moi c'est #{user.first_name} ! Passioné.e de #{user.skills.first.name} depuis mon enfance, j'aime transmettre ma passion."
  booking = user.bookings.last
  if booking
    bio += " Je suis également très curieux.se et souhaite acquérir des compétences en #{booking.skill.name}."
  end
  user.update!(bio: bio)
end

puts "bookings created, with its chatrooms"

chatrooms = Chatroom.all

# Create 10 Messages
10.times do
  Message.create!(
    content: Faker::Lorem.sentence,
    user: User.all.sample,
    chatroom: chatrooms.sample
  )
end


# Create 30 Reviews

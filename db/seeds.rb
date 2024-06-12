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
  bio: "Salut ! Je m'appelle Mattieu, j'ai appris le travail du bois auprès de mon grand-père et depuis je n'ai plus arrêté. Transmettre cet héritage est mon plus grand plaisir ! Récemment j'ai entendu Mistral Gagnant et j'ai A-DO-RÉ ! J'ai vraiment envie d'apprendre à le jouer au piano.",
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
  bio: "Bonjour moi c'est Jeanot ! Passioné de piano depuis mon enfance, j'aime transmettre ma passion. Je suis également très curieux et souhaite acquérir des compétences en menuiserie.",
  address: "11-3 Rue Jean-Baptiste Dumay, 75020 Paris",
  city: 'Paris',
  area: 1,
  token: 5,
  latitude: 48.8738989,
  longitude: 2.3879974
)

file = URI.open("https://images.unsplash.com/photo-1610429419519-8cdee5a8e615?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTB8fHBpYW5pc3RlfGVufDB8fDB8fHww")
mattieu_user.photo.attach(io: file, filename: "#{mattieu_user.first_name}.jpg", content_type: "image/jpeg")
mattieu_user.save!

file = URI.open("https://images.unsplash.com/photo-1610429419519-8cdee5a8e615?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTB8fHBpYW5pc3RlfGVufDB8fDB8fHww")
jean_user.photo.attach(io: file, filename: "#{jean_user.first_name}.jpg", content_type: "image/jpeg")
jean_user.save!

goal = ["découverte", "passion", "reconversion"]
name = ["poterie", "menuiserie", "dessin", "guitare", "running", "chinois"]

puts "creating skill for test_user"

activites_avec_icones = {
  "Sport" => {
      "icon" => "⚽️",
      "activities" => ["Football", "Basketball", "Natation", "Course à pied"]
  },
  "Cuisine" => {
      "icon" => "🍽️",
      "activities" => ["Pâtisserie", "Cuisine italienne", "Grillades", "Cuisine végétarienne"]
  },
  "Musique" => {
      "icon" => "🎵",
      "activities" => ["Guitare", "Piano", "Chant", "Batterie"]
  },
  "Lecture" => {
      "icon" => "📚",
      "activities" => ["Romans", "Poésie", "Biographies", "Essais philosophiques"]
  },
  "Voyage" => {
      "icon" => "✈️",
      "activities" => ["Randonnée", "Visites culturelles", "Camping", "Tourisme gastronomique"]
  },
  "Art" => {
      "icon" => "🎨",
      "activities" => ["Peinture", "Sculpture", "Photographie", "Dessin"]
  },
  "Technologie" => {
      "icon" => "💻",
      "activities" => ["Programmation", "Robotique", "Impression 3D", "Réalité virtuelle"]
  },
  "Jardinage" => {
      "icon" => "🌱",
      "activities" => ["Plantes d'intérieur", "Potager", "Paysagisme", "Jardin biologique"]
  },
  "Loisirs créatifs" => {
      "icon" => "✂️",
      "activities" => ["Tricot", "Scrapbooking", "Couture", "Origami"]
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
  { address: '1 Rue Curnonsky, Paris', latitude: 48.8910696, longitude: 2.297456 },
]

  user = 30.times.map do |i|
    address = addresses.sample

    user = User.create!(
      email: Faker::Internet.unique.email,
      password: 'password',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      age: rand(18..65),
      genre: ['Homme', 'Femme', 'Autre'].sample,
      bio: "test",
      city: Faker::Address.city,
      area: rand(1..10),
      token: rand(1..5),
      address: address[:address],
      latitude: address[:latitude],
      longitude: address[:longitude],
    )

    # file = URI.open(user_img[i])
    if user.genre == 'Femme'
      file = URI.open("https://xsgames.co/randomusers/avatar.php?g=female")
    elsif user.genre == 'Homme'
      file = URI.open("https://xsgames.co/randomusers/avatar.php?g=male")
    else
      file = URI.open("https://xsgames.co/randomusers/avatar.php?g=female")
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

30.times.map do
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
bookings = Booking.all
30.times do
  Review.create!(
    rating: rand(1..5),
    comment: Faker::Lorem.paragraph,
    title: Faker::Lorem.sentence,
    booking: bookings.sample,
    user: User.all.sample
  )
end

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

test_user = User.create!(
  email: 'test@example.com',
  password: 'password',
  first_name: 'Mattieu',
  last_name: 'Le Boss',
  age: 30,
  genre: 'Other',
  bio: 'I want to learn the piano',
  city: 'St Ger la team',
  area: 1,
  token: 5
)

goal = ["découverte", "passion", "reconversion"]
name = ["poterie", "menuiserie", "dessin", "guitare", "running", "chinois"]

puts "creating skill for test_user"

Skill.create!(
  name: name.sample,
  goal: goal.sample,
  experience_year: rand(1..20),
  category: Skill::CATEGORY.sample,
  user: test_user
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
  user = 5.times.map do |i|
    user = User.create!(
      email: Faker::Internet.unique.email,
      password: 'password',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      age: rand(18..65),
      genre: ['Male', 'Female', 'Other'].sample,
      bio: Faker::Lorem.sentence,
      city: Faker::Address.city,
      area: rand(1..10),
      token: rand(1..5)
    )

    file = URI.open(user_img[i])
    user.photo.attach(io: file, filename: "#{user.first_name}.jpg", content_type: "image/jpeg")
    user.save!

    Skill.create!(
      name: name.sample,
      goal: goal.sample,
      experience_year: rand(1..20),
      category: Skill::CATEGORY.sample,
      user: user
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

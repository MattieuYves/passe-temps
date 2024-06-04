# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

require 'faker'

# Clear existing data
ActiveRecord::Base.transaction do
  User.destroy_all
  Skill.destroy_all
  Booking.destroy_all
  Chatroom.destroy_all
  Message.destroy_all
  Review.destroy_all

  test_user = User.create!(
    email: 'test@example.com',
    password: 'password',
    first_name: 'Test',
    last_name: 'User',
    age: 30,
    genre: 'Other',
    bio: 'This is a test user.',
    city: 'Test City',
    area: 1,
    token: 1000
  )
  goal = ["découverte", "passion", "reconversion"]
  name = ["poterie", "menuiserie", "dessin", "guitare", "running", "chinois"]

  Skill.create!(
    name: name.sample,
    goal: goal.sample,
    experience_year: rand(1..20),
    category: Skill::CATEGORY.sample,
    user: test_user
  )


  # Create 10 Users
  users = 5.times.map do
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

    Skill.create!(
      name: name.sample,
      goal: goal.sample,
      experience_year: rand(1..20),
      category: Skill::CATEGORY.sample,
      user: user
    )

  end


  # Create 10 Bookings
  bookings = 10.times.map do
    Booking.create!(
      duration: rand(1..4),
      token_cost: 1,
      session_format: ['Distance', 'Physique'].sample,
      skill: Skill.all.sample,
      user: User.all.sample,
      start_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
      end_date: Faker::Date.between(from: Date.today, to: 1.year.from_now),
      content: Faker::Lorem.paragraph,
      status: %w[pending confirmed rejected].sample
    )
  end

  # Create 10 Chatrooms
  chatrooms = 10.times.map do
    Chatroom.create!(
      name: Faker::Lorem.word,
      booking: bookings.sample
    )
  end

  # Create 10 Messages
  10.times do
    Message.create!(
      content: Faker::Lorem.sentence,
      user: User.all.sample,
      chatroom: chatrooms.sample
    )
  end

  # Create 10 Reviews
  10.times do
    Review.create!(
      rating: rand(1..5),
      comment: Faker::Lorem.paragraph,
      title: Faker::Lorem.sentence,
      booking: bookings.sample,
      user: User.all.sample
    )
  end
end

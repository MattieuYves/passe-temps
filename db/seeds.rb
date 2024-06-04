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
  Session.destroy_all
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

  # Create 10 Users
  users = 5.times.map do
    User.create!(
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
    
  end

  # Create 10 Skills
  goal = ["découverte", "passion", "reconversion"]
  name = ["poterie", "menuiserie", "dessin", "guitare", "running", "chinois"]
  category = ['Art', 'Langue', 'Musique', 'Bricolage']

  skills = 10.times.map do
    Skill.create!(
      name: name.sample,
      goal: goal.sample,
      experience_year: rand(1..20),
      user: users.sample,
      category: category.sample
    )
  end

  # Create 10 Sessions
  sessions = 10.times.map do
    Session.create!(
      duration: rand(1..4),
      token_cost: 1,
      session_format: ['Distance', 'Physique'].sample,
      skill: skills.sample,
      user: users.sample,
      start_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
      end_date: Faker::Date.between(from: Date.today, to: 1.year.from_now),
      content: Faker::Lorem.paragraph,
      status: ['Pending', 'Accepted', 'Refused'].sample
    )
  end

  # Create 10 Chatrooms
  chatrooms = 10.times.map do
    Chatroom.create!(
      name: Faker::Lorem.word,
      session: sessions.sample
    )
  end

  # Create 10 Messages
  10.times do
    Message.create!(
      content: Faker::Lorem.sentence,
      user: users.sample,
      chatroom: chatrooms.sample
    )
  end

  # Create 10 Reviews
  10.times do
    Review.create!(
      rating: rand(1..5).to_f,
      comment: Faker::Lorem.paragraph,
      title: Faker::Lorem.sentence,
      session: sessions.sample,
      user: users.sample
    )
  end
end

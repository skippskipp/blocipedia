require 'faker'

# Create Users
5.times do
     User.create!(
        email: Faker::Internet.email,
        password: Faker::Internet.password,
        username: Faker::Name.first_name
      )
end
users = User.all

# Create Chuck Norris Wikis
10.times do
  Wiki.create!(
  title: Faker::ChuckNorris.fact,
  body: Faker::Lorem.sentence(15),
  user: users.sample,
  private: false
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"

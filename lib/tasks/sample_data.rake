namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@maia.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@maia.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  
  users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.debates.create!(description: content) }
  end
  end
end
User.create! name: "Example User",
            email: "admin@gmail.com",
            password: ENV["password"],
            password_confirmation: ENV["password"],
            is_admin: true,
            activated: true,
            activated_at: Time.zone.now

40.times do |n|
  User.create! name: Faker::Name.name,
              email: "example-#{n+1}@gmail.com",
              password: ENV["password"],
              password_confirmation: ENV["password"],
              activated: true,
              activated_at: Time.zone.now
end

users = User.order(:created_at).take(6)
  30.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

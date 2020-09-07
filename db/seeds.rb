User.create! name: "Example User",
            email: "admin@gmail.com",
            password: "password",
            password_confirmation: "password",
            is_admin: true

40.times do |n|
  User.create! name: Faker::Name.name,
              email: "example-#{n+1}@gmail.com",
              password: "password",
              password_confirmation: "password"
end

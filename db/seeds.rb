User.create!(name: "Diem Ly Vu",
  email: "diemly.admin@example.com",
  password: "111111",
  password_confirmation: "111111",
  admin: true)

User.create!(name: "Example User", email: "example@railstutorial.org",
  password: "foobar", password_confirmation: "foobar", admin: true)

49.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password)
end

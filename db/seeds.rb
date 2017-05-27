User.create!(name: "Nguyen Huy Long",
  email: "nguyenhuylong5695@gmail.com",
  password: "123456",
  password_confirmation: "123456",
)

User.create!(name: "Admin", email: "admin@gmail.com",
  password: "123456", password_confirmation: "123456", admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password)
end

Category.create! ([
  {name: "Việt Nam danh tác"},
  {name: "Lãng mạn"},
  {name: "Trinh thám"},
  {name: "Thiếu nhi"},
  {name: "Gíao dục"}
])

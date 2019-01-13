99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password)
end

99.times do |n|
  title  = Faker::Name.name
  Book.create!(
      title: title,
      category_id: 1,
      author: title,
      publish_date: Book.find(1).publish_date)
end

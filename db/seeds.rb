# Users
User.create!(name:  "Admin",
             email: "admin@seed.ru",
             password:              "password",
             password_confirmation: "password",
             admin: true)

10.times do |n|
  name  = Faker::Name.name
  email = "user#{n+1}@seed.ru"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# Menu items
20.times do |n|
  name = "#{Faker::Food.dish}-#{n}"
  kind = "first"
  price = Random.rand(20.0) + 0.1
  Item.create!(name:  name,
               kind:  kind,
               price: price)
end

20.times do |n|
  name = "#{Faker::Dessert.variety}-#{n}"
  kind = "main"
  price = Random.rand(30.0) + 0.1
  Item.create!(name:  name,
               kind:  kind,
               price: price)
end

20.times do |n|
  name = "#{Faker::Coffee.blend_name}-#{n}"
  kind = "drink"
  price = Random.rand(5.0) + 0.1
  Item.create!(name:  name,
               kind:  kind,
               price: price)
end

# Orders
users = User.all
first_courses = Item.where(kind: "first").take(10)
main_courses  = Item.where(kind: "main").take(10)
drinks        = Item.where(kind: "drink").take(10) 
users.each do |user|
  first_course = first_courses[Random.rand(10)] 
  main_course  = main_courses[Random.rand(10)]
  drink        = drinks[Random.rand(10)]
  price = first_course.price + main_course.price + drink.price
  user.orders.create!(price:        price, 
                      first_course: first_course,
                      main_course:  main_course,
                      drink:        drink)
end
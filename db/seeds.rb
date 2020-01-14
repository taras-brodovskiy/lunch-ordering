# Users
User.create!(name:  "Admin",
             email: "admin@seed.ru",
             password:              "password",
             password_confirmation: "password",
             admin: true)

User.create!(name: "Supplier",
             email: "supplier@seed.ru",
             password:              "password",
             password_confirmation: "password",
             supplier: true)

40.times do |n|
  name  = Faker::Name.name
  email = "user#{n+1}@seed.ru"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# Items
40.times do |n|
  name = "#{Faker::Food.dish}-#{n+1}"
  kind = "first"
  fprice = Random.rand(20.0) + 0.1
  sprice = "%0.2f" % [fprice]
  price = BigDecimal.new(sprice)
  photo = File.open("storage/first_course.png")
  item = Item.create!(name:  name,
               kind:  kind,
               price: price,
               photo: photo)
end

45.times do |n|
  name = "#{Faker::Dessert.variety}-#{n+1}"
  kind = "main"
  fprice = Random.rand(30.0) + 0.1
  sprice = "%0.2f" % [fprice]
  price = BigDecimal.new(sprice)
  photo = File.open("storage/main_course.png")
  item = Item.create!(name:  name,
               kind:  kind,
               price: price,
               photo: photo)
end

35.times do |n|
  name = "#{Faker::Coffee.blend_name}-#{n+1}"
  kind = "drink"
  fprice = Random.rand(5.0) + 0.1
  sprice = "%0.2f" % [fprice]  
  price = BigDecimal.new(sprice)
  photo = File.open("storage/drink.png")
  item = Item.create!(name:  name,
                      kind:  kind,
                      price: price,
                      photo: photo)
end

# Orders
users = User.all
first_courses = Item.where(kind: "first").take(10)
main_courses  = Item.where(kind: "main").take(10)
drinks        = Item.where(kind: "drink").take(10)
order_date = Time.zone.now.to_date - 1.day
users.each do |user|
  first_course = first_courses[Random.rand(10)] 
  main_course  = main_courses[Random.rand(10)]
  drink        = drinks[Random.rand(10)]
  price = first_course.price + main_course.price + drink.price
  user.orders.create!(order_date:   order_date,
                    price:        price,
                    first_course: first_course,
                    main_course:  main_course,
                    drink:        drink)
end

#Users without orders
10.times do |n|
  name  = Faker::Name.name
  email = "user#{n+1}wo@seed.ru"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# Menu
5.times do |n|
  menu_date = Time.zone.now.to_date - (5.day - n.day)
  menu = Menu.create!(menu_date: menu_date) 
  first_courses = Item.where(kind: "first").take(20)
  main_courses  = Item.where(kind: "main").take(20)
  drinks        = Item.where(kind: "drink").take(20)   
  items = first_courses + main_courses + drinks    
  items.each do |item|  
    menu.fillings.create!(menu: menu,
                          item: item)
  end
end

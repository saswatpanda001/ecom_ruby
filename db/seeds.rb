require 'faker'

# Clear existing data
Province.destroy_all
Category.destroy_all
User.destroy_all
Product.destroy_all
Order.destroy_all
OrderItem.destroy_all
CartItem.destroy_all

# Create Provinces
5.times do
  Province.create!(
    name: Faker::Address.state,
    gst: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    pst: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    hst: Faker::Number.decimal(l_digits: 2, r_digits: 2)
  )
end

provinces = Province.all

# Create Categories
categories = []
5.times do
  categories << Category.create!(name: Faker::Commerce.department)
end

# Create Users
users = []
10.times do
  users << User.create!(
    username: Faker::Internet.username,
    email: Faker::Internet.unique.email,
    encrypted_password: Faker::Internet.password(min_length: 8),
    admin: [true, false].sample,
    province: provinces.sample
  )
end

# Create Products
products = []
100.times do
  products << Product.create!(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 10.0..1000.0),
    on_sale: [true, false].sample,
    category: categories.sample,
    image: Faker::LoremFlickr.image(size: "300x300", search_terms: ['product'])
  )
end

# Create Orders
orders = []
users.each do |user|
  rand(1..3).times do
    orders << Order.create!(
      user: user,
      status: %w[pending completed cancelled].sample,
      total_price: Faker::Commerce.price(range: 50.0..5000.0),
      payment_id: Faker::Alphanumeric.alphanumeric(number: 10),
      province: user.province
    )
  end
end

# Create Order Items
orders.each do |order|
  rand(1..5).times do
    OrderItem.create!(
      order: order,
      product: products.sample,
      quantity: rand(1..5),
      product_price: Faker::Commerce.price(range: 10.0..1000.0)
    )
  end
end

# Create Cart Items
users.each do |user|
  rand(1..5).times do
    CartItem.create!(
      user: user,
      product: products.sample,
      quantity: rand(1..3)
    )
  end
end

puts "Database has been seeded successfully!"

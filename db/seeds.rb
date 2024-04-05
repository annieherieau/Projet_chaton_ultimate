# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# open-uri
require 'open-uri'
# Faker
require 'faker'
Faker::Config.locale='fr'
Faker::UniqueGenerator.clear

# Effacer toutes les tables
Item.destroy_all
User.destroy_all
Cart.destroy_all
Order.destroy_all
CartItem.destroy_all
OrderItem.destroy_all
ActiveStorage::Attachment.all.each { |attachment| attachment.purge }

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts("--- Start Seeding ---")
count = 0
19.times do |i|
  name =''
  name = Faker::Creature::Cat.unique.name until name.length >5
  item = Item.create!(
    title: name,
    description: Faker::Lorem.paragraph(sentence_count: rand(2..7)),
    price: rand(1..10)
  )
  filename = chaton + '%02d' % i + '.jpg'
  url = ENV['AWS_S3_URI'] + filename
  item.photo.attach(io: URI.open(url), filename: filename.split('.').first, content_type: "image/jpg")
  count += 1
  puts (count)
end
puts(" Items créés")


emails_array =['annie.herieau@gmail.com', "r.robena@gmail.com", "malo.bastianelli@gmail.com", "yann.rezigui@gmail.com"]
emails_array.each do |e|
  user = User.create!(
    email: e,
    password: "1&Azert",
    admin: [true, false].sample
  )
  chart = user.carts.last
  rand(0..3).times do |i|
    CartItem.create!(
      cart: chart,
      item: Item.all.sample
    )
  end

  rand(1..4).times do |i|
    order = Order.create!(
      user: user
    )
    rand(1..6).times do |i|
      OrderItem.create!(
        order: order,
        item: Item.all.sample
      )
    end
  end
  
end
puts("> 4 Users créés")




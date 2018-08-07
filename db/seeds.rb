# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = Category.create([{category: 'First Category'}, {category: 'Second Category'}])
user = User.create({email: 'lexa288@mail.ru', nick: 'i3po', role: ['admin', 'moderator'], password: 'test'})
user2 = User.create({email: Faker::Internet.email, nick: Faker::Name.name, role: ['client'], password: 'test'})
user3 = User.create({email: Faker::Internet.email, nick: Faker::Name.name, role: ['client'], password: 'test'})
20.times do
  Item.create([{
                   user_id: user.id, category: categories.first, title: Faker::Book.title, description: Faker::Lorem.paragraph, price: Faker::Number.between(10, 1000), rating: Faker::Number.between(1, 10),
               },
               {
                   user_id: user.id, category: categories.first, title: Faker::Book.title, description: Faker::Lorem.paragraph, price: Faker::Number.between(10, 1000), rating: Faker::Number.between(1, 10)
               },
               {
                   user_id: user.id, category: categories.first, title: Faker::Book.title, description: Faker::Lorem.paragraph, price: Faker::Number.between(10, 1000), rating: Faker::Number.between(1, 10)
               },
               {
                   user_id: user.id, category: categories.second, title: Faker::Book.title, description: Faker::Lorem.paragraph, price: Faker::Number.between(10, 1000), rating: Faker::Number.between(1, 10)
               },
               {
                   user_id: user2.id, category: categories.second, title: Faker::Book.title, description: Faker::Lorem.paragraph, price: Faker::Number.between(10, 1000), rating: Faker::Number.between(1, 10)
               },
               {
                   user_id: user2.id, category: categories.second, title: Faker::Book.title, description: Faker::Lorem.paragraph, price: Faker::Number.between(10, 1000), rating: Faker::Number.between(1, 10)
               },
               {
                   user_id: user3.id, category: categories.second, title: Faker::Book.title, description: Faker::Lorem.paragraph, price: Faker::Number.between(10, 50), rating: Faker::Number.between(1, 10)
               },
              ])
end
Item.all.each {|item|
  if item.uploads.size === 0
    item.uploads.create([{
                             :file => File.new(Rails.root.join('public', 'eg.jpg')),
                             :item_id => item.id
                         },
                         {
                             :file => File.new(Rails.root.join('public', '111.jpg')),
                             :item_id => item.id
                         },
                        ])
  end

  }
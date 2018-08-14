# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create([{category: 'Jedi Swords'}, {category: 'Space Ships'}, {category: 'Something interesting'}, {category: 'Other'}])
User.create({email: 'lexa288@mail.ru', nick: 'i3po', role: ['admin', 'moderator'], password: 'test'})
User.create({email: Faker::Internet.email, nick: Faker::Name.name, role: ['client'], password: 'test'})
User.create({email: Faker::Internet.email, nick: Faker::Name.name, role: ['client'], password: 'test'})

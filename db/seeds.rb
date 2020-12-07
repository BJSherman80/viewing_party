# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all

User.create!(name: 'Jake', email: 'jake@email.com', password: 'jake')
User.create!(name: 'Dani', email: 'dani@email.com', password: 'dani')
User.create!(name: 'Brett', email: 'brett@email.com', password: 'brett')

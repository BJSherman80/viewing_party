# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Party.destroy_all

jake = User.create!(name: 'Jake', email: 'jake@email.com', password: 'jake')
dani = User.create!(name: 'Dani', email: 'dani@email.com', password: 'dani')
brett = User.create!(name: 'Brett', email: 'brett@email.com', password: 'brett')

jake_movie = Movie.create!(title: "The Fifth Element" , runtime: 117 , api_id: 400)
dani_movie = Movie.create!(title: "The Dark Crytsal" , runtime: 121 , api_id: 300)
brett_movie = Movie.create!(title: "Princess Diaries" , runtime: 100 , api_id: 600)

jake.parties.create!(date: "12/31/1999", start_time: "11:59", party_duration: 600, movie_id: jake_movie.id)
dani.parties.create!(date: "07/14/2008", start_time: "7:25", party_duration: 160, movie_id: dani_movie.id)
brett.parties.create!(date: "09/19/1860", start_time: "4:20", party_duration: 500, movie_id: brett_movie.id)


friendship1 = Friendship.create(friend: brett, user: dani)
friendship2 = Friendship.create(friend: dani, user: brett)

friendship3 = Friendship.create(friend: jake, user: brett)
friendship4 = Friendship.create(friend: brett, user: jake)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# rails db:{drop,create,migrate,seed} 

puts "Creating Shelters"
sleep(1)
Shelter.create!(name: "Shelter 1", city: "Parker", rank: 4, foster_program: false)
Shelter.create!(name: "Shelter 2", city: "Littleton", rank: 3, foster_program: true)
Shelter.create!(name: "Shelter 3", city: "Denver", rank: 1, foster_program: true)
Shelter.create!(name: "Shelter 4", city: "Boulder", rank: 2, foster_program: true)
puts "Shelters Created"

puts "Creating Pets"
sleep(1)
Pet.create!(name: "Bear", age: 4, breed: "Malamute", adoptable: true, shelter_id: 2)
Pet.create!(name: "Max", age: 8, breed: "Siberian Husky", adoptable: true, shelter_id: 1)
Pet.create!(name: "Leo", age: 3, breed: "Golden Retriever", adoptable: true, shelter_id: 4)
Pet.create!(name: "Bella", age: 5, breed: "Beagle", adoptable: true, shelter_id: 3)
Pet.create!(name: "Bailey", age: 10, breed: "Chihuahua", adoptable: true, shelter_id: 2)
Pet.create!(name: "Alfie", age: 3, breed: "Golden Retriever", adoptable: true, shelter_id: 1)
Pet.create!(name: "Annie", age: 8, breed: "German Shepherd", adoptable: true, shelter_id: 4)
Pet.create!(name: "Bean", age: 2, breed: "Poodle", adoptable: true, shelter_id: 3)
Pet.create!(name: "Apollo", age: 1, breed: "Golden Retriever", adoptable: true, shelter_id: 2)
Pet.create!(name: "Charlie", age: 10, breed: "German Shepherd", adoptable: true, shelter_id: 1)
puts "Pets Created"
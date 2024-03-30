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

puts "Creating Applications"
sleep(1)
Application.create!(name: "John Wing", street_address: "1234 Long St.", city: "Star", state: "CA", zip_code: "12545", description: "I have always loved dogs and would like to adopt one!", status: "In Progress")
Application.create!(name: "Sarah Foster", street_address: "123334 Apple St.", city: "Vegas", state: "NV", zip_code: "90042", description: "I have two dogs already and they need another playmate.", status: "Accepted")
Application.create!(name: "Michael Jordan", street_address: "559 Strawberry Ln.", city: "Eugene", state: "OR", zip_code: "76851", description: "I foster puppies!", status: "Pending")
Application.create!(name: "Kurt Russell", street_address: "152 Bowery St.", city: "New York", state: "NY", zip_code: "42511", description: "I am crazy!", status: "Rejected")
puts "Applications Created"

puts "Linking Pets to Applications"
sleep(1)
ApplicationPet.create!(pet_id: 7, application_id: 1)
ApplicationPet.create!(pet_id: 4, application_id: 1)
ApplicationPet.create!(pet_id: 1, application_id: 1)
ApplicationPet.create!(pet_id: 2, application_id: 2)
ApplicationPet.create!(pet_id: 3, application_id: 2)
ApplicationPet.create!(pet_id: 9, application_id: 2)
ApplicationPet.create!(pet_id: 1, application_id: 3)
ApplicationPet.create!(pet_id: 7, application_id: 3)
ApplicationPet.create!(pet_id: 4, application_id: 4)
ApplicationPet.create!(pet_id: 9, application_id: 4)
puts "Applications Linked"

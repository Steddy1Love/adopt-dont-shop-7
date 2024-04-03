require "rails_helper"

RSpec.describe "admin shelters index page" do
    
    # User Story 10
    it 'admin shelters index has all shelters listed in reverse alphabetical order' do
        @shelter_1 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
        @shelter_2 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @shelter_3 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)

        visit "/admin/shelters"

        within "#shelters_list" do
            expect(@shelter_3.name).to appear_before (@shelter_1.name)
            expect(@shelter_1.name).to appear_before (@shelter_2.name)            
        end
    end

    # User Story 11
    it 'admin shelters index has section for all shelters with pending applications' do
        @shelter_1 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
        @shelter_2 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @shelter_3 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)

        @pet_1 = Pet.create!(name: "Bear", age: 4, breed: "Malamute", adoptable: true, shelter_id: @shelter_1.id)
        @pet_2 = Pet.create!(name: "Max", age: 8, breed: "Siberian Husky", adoptable: true, shelter_id: @shelter_2.id)
        @pet_3 = Pet.create!(name: "Leo", age: 3, breed: "Golden Retriever", adoptable: true, shelter_id: @shelter_1.id)
        @pet_4 = Pet.create!(name: "Bella", age: 5, breed: "Beagle", adoptable: true, shelter_id: @shelter_3.id)
        
        @app_1 = Application.create!(name: "John Wing", street_address: "1234 Long St.", city: "Star", state: "CA", zip_code: "12545", description: "I have always loved dogs and would like to adopt one!", status: "Pending")
        @app_2 = Application.create!(name: "Sarah Foster", street_address: "123334 Apple St.", city: "Vegas", state: "NV", zip_code: "90042", description: "I have two dogs already and they need another playmate.", status: "In Progress")
        @app_3 = Application.create!(name: "Michael Jordan", street_address: "559 Strawberry Ln.", city: "Eugene", state: "OR", zip_code: "76851", description: "I foster puppies!", status: "Pending")
        @app_4 = Application.create!(name: "Kurt Russell", street_address: "152 Bowery St.", city: "New York", state: "NY", zip_code: "42511", description: "I am crazy!", status: "Pending")

        @app_pet_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @app_1.id, status: "In Progress" )
        @app_pet_2 = ApplicationPet.create!(pet_id: @pet_3.id, application_id: @app_2.id, status: "In Progress" )
        @app_pet_3 = ApplicationPet.create!(pet_id: @pet_3.id, application_id: @app_4.id, status: "In Progress" )
        @app_pet_4 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @app_3.id, status: "In Progress" )
        @app_pet_5 = ApplicationPet.create!(pet_id: @pet_4.id, application_id: @app_2.id, status: "In Progress" )

        visit "/admin/shelters"

        within "#pending_app_shelters_list" do
            expect(@shelter_1.name).to appear_before (@shelter_2.name)          
        end
    end

end
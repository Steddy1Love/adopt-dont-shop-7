require "rails_helper"

RSpec.describe "applications show page" do

    # User Story 1
    it 'applications show page lists all content' do
        @new_shelter = Shelter.create!(name: "Parker Animal Shelter", city: "Parker", rank: 4, foster_program: false)
        @pet_1 = Pet.create!(name: "Bear", age: 4, breed: "Malamute", adoptable: true, shelter_id: @new_shelter.id)
        @pet_2 = Pet.create!(name: "Max", age: 8, breed: "Siberian Husky", adoptable: true, shelter_id: @new_shelter.id)
        @new_application = Application.create!(name: "John Wing", street_address: "1234 Long St.", city: "Star", state: "CA", zip_code: "12545", description: "I have always loved dogs and would like to adopt one!", status: "In Progress")
        ApplicationPet.create!(pet_id: @pet_1.id, application_id: @new_application.id)
        ApplicationPet.create!(pet_id: @pet_2.id, application_id: @new_application.id)

        visit "/applications/#{@new_application.id}"

        expect(page).to have_content ("Application ##{@new_application.id}")
        expect(page).to have_content ("Application Status: #{@new_application.status}")
        expect(page).to have_content ("Applicant Name: #{@new_application.name}")
        expect(page).to have_content ("Applicant's Address: #{@new_application.street_address}, #{@new_application.city}, #{@new_application.state} #{@new_application.zip_code}")
        expect(page).to have_content ("#{@pet_1.name}")
        expect(page).to have_content ("#{@pet_2.name}")
    end

    it 'applications show page has pet links that can be clicked on' do   
        @new_shelter = Shelter.create!(name: "Parker Animal Shelter", city: "Parker", rank: 4, foster_program: false)
        @pet_1 = Pet.create!(name: "Bear", age: 4, breed: "Malamute", adoptable: true, shelter_id: @new_shelter.id)
        @pet_2 = Pet.create!(name: "Max", age: 8, breed: "Siberian Husky", adoptable: true, shelter_id: @new_shelter.id)
        @new_application = Application.create!(name: "John Wing", street_address: "1234 Long St.", city: "Star", state: "CA", zip_code: "12545", description: "I have always loved dogs and would like to adopt one!", status: "In Progress")
        ApplicationPet.create!(pet_id: @pet_1.id, application_id: @new_application.id)
        ApplicationPet.create!(pet_id: @pet_2.id, application_id: @new_application.id)

        visit "/applications/#{@new_application.id}"

        click_on "#{@pet_1.name}"

        expect(current_path).to eq("/pets/#{@pet_1.id}")
    end    

    describe 'search for pets for application' do
        before :each do
            @new_shelter = Shelter.create!(name: "Parker Animal Shelter", city: "Parker", rank: 4, foster_program: false)
            @pet_1 = Pet.create!(name: "Bear", age: 4, breed: "Malamute", adoptable: true, shelter_id: @new_shelter.id)
            @pet_2 = Pet.create!(name: "Max", age: 8, breed: "Siberian Husky", adoptable: true, shelter_id: @new_shelter.id)
            @pet_3 = Pet.create!(name: "Leo", age: 3, breed: "Golden Retriever", adoptable: true, shelter_id: @new_shelter.id)
            @new_application = Application.create!(name: "John Wing", street_address: "1234 Long St.", city: "Star", state: "CA", zip_code: "12545", description: "I have always loved dogs and would like to adopt one!", status: "In Progress")
        end
    
        # User Story 4
        it 'can search a pet by name' do
            visit "/applications/#{@new_application.id}"

            fill_in "search", with: "Leo"
            click_button 'Search by Pet Name'

            within "#add_pet" do
                expect(page).to have_content("Leo") 
                expect(page).to have_button("Add Pet to this Application")
                expect(current_path).to eq "/applications/#{@new_application.id}"            
            end
        end
    
        # User Story 8
        it 'can search with a partial query' do
            visit "/applications/#{@new_application.id}"

            fill_in 'search', with: 'Le'
            click_on 'Search by Pet Name'

            expect(page).to have_content("Leo")
            expect(page).to have_button('Add Pet to this Application')
            expect(page).to have_button('Search by Pet Name')
            expect(current_path).to eq "/applications/#{@new_application.id}"
        end

        # User Story 9
        it 'can search case insensitive' do
            visit "/applications/#{@new_application.id}"

            fill_in 'search', with: 'LeO'
            click_on 'Search by Pet Name'

            expect(page).to have_content("Leo")
            expect(page).to have_button('Add Pet to this Application')
            expect(current_path).to eq "/applications/#{@new_application.id}"
        end
    end
    
    # User Story 5
    describe 'adding a pet to an application' do
        before :each do
            @new_shelter = Shelter.create!(name: "Parker Animal Shelter", city: "Parker", rank: 4, foster_program: false)
            @pet_1 = Pet.create!(name: "Bear", age: 4, breed: "Malamute", adoptable: true, shelter_id: @new_shelter.id)
            @pet_2 = Pet.create!(name: "Max", age: 8, breed: "Siberian Husky", adoptable: true, shelter_id: @new_shelter.id)
            @pet_3 = Pet.create!(name: "Leo", age: 3, breed: "Golden Retriever", adoptable: true, shelter_id: @new_shelter.id)
            @new_application = Application.create!(name: "John Wing", street_address: "1234 Long St.", city: "Star", state: "CA", zip_code: "12545", description: "I have always loved dogs and would like to adopt one!", status: "In Progress")
            ApplicationPet.create!(pet_id: @pet_1.id, application_id: @new_application.id)
        end
        
        it 'has a button to add a pet to an application after searching by name' do
            visit "/applications/#{@new_application.id}"
 
            fill_in 'search', with: 'Max'
            click_button 'Search by Pet Name'

            expect(page).to have_button('Search by Pet Name')
            expect(page).to have_content("Max")
            expect(page).to have_button('Add Pet to this Application')
            expect(page).to_not have_content("Leo")
        end
    
        it 'adds a pet to an application and redirects to application show page with new pet added' do
            visit "/applications/#{@new_application.id}"
 
            fill_in 'search', with: 'Max'
            click_button 'Search by Pet Name'

            expect(current_path).to eq "/applications/#{@new_application.id}"
            expect(page).to have_content("Max")
        
            click_button 'Add Pet to this Application'

            expect(page).to have_content(@pet_2.name)
            expect(@new_application.pets).to eq([@pet_1, @pet_2])
        end
    end
end
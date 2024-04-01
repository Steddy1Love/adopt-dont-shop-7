require "rails_helper"

RSpec.describe "applications show page" do
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

    it 'applications show pet links that can be clicked on' do   
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
            @new_application = Application.create!(name: "John Wing", street_address: "1234 Long St.", city: "Star", state: "CA", zip_code: "12545", description: "I have always loved dogs and would like to adopt one!", status: "In Progress")
            ApplicationPet.create!(pet_id: @pet_1.id, application_id: @new_application.id)
            ApplicationPet.create!(pet_id: @pet_2.id, application_id: @new_application.id)    
        end

        # User story 4
        it 'has a search for pets by name' do
            visit new_application_path

            expect(page).to have_field("pet_name")
            expect(page).to have_button("Search by Pet Name")
        end
    
        # User story 4
        it 'can search a pet by name' do
            visit new_application_path

            fill_in 'pet_name', with: 'Bear'
            click_on 'Search by Pet Name'

            expect(page).to have_content("Bear")
            expect(current_path).to eq show_application_path
        end
    
        # User story 9
        it 'can search case insensitive' do
            visit new_application_path

            fill_in 'pet_name', with: 'bEaR'
            click_on 'Search by Pet Name'

            expect(page).to have_content("Bear")
            expect(current_path).to eq show_application_path
        end
    
        # User story 8
        it 'can search with a partial query' do
            visit new_application_path

            fill_in 'pet_name', with: 'BeA'
            click_on 'Search by Pet Name'

            expect(page).to have_content("Bear")
            expect(current_path).to eq show_application_path
        end
    end
    
    describe 'user story 5' do
        it 'has a button to add a pet to an application after searching by name' do
            visit new_application_path

        end
    
        it 'adds a pet to an application and redirects to application show page with new pet added' do
            visit new_application_path

        end
    end
end
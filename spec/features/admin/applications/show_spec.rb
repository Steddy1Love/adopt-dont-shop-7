require "rails_helper"

RSpec.describe "Admin Application Show Page", type: :feature do
  before :each do
    @new_shelter = Shelter.create!(name: "Parker Animal Shelter", city: "Parker", rank: 4, foster_program: false)
    @pet_1 = Pet.create!(name: "Bear", age: 4, breed: "Malamute", adoptable: true, shelter_id: @new_shelter.id)
    @pet_2 = Pet.create!(name: "Max", age: 8, breed: "Siberian Husky", adoptable: true, shelter_id: @new_shelter.id)
    @pet_3 = Pet.create!(name: "Bella", age: 1, breed: "Basenji", adoptable: true, shelter_id: @new_shelter.id)
    @pet_4 = Pet.create!(name: "Annie", age: 2, breed: "Cairn Terrier", adoptable: true, shelter_id: @new_shelter.id)
    @new_application_1 = Application.create!(name: "John Wing", street_address: "1234 Long St.", city: "Star", state: "CA", zip_code: "12545", description: "I have always loved dogs and would like to adopt one!", status: "In Progress")
    @new_application_2 = Application.create!(name: "Michael Vick", street_address: "101 Mullholand Dr.", city: "Los Angeles", state: "CA", zip_code: "90210", description: "Can this dog fight?", status: "In Progress")
    @app_pet_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @new_application_1.id)
    @app_pet_2 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @new_application_1.id)
    @app_pet_3 = ApplicationPet.create!(pet_id: @pet_3.id, application_id: @new_application_2.id)
    @app_pet_4 = ApplicationPet.create!(pet_id: @pet_4.id, application_id: @new_application_2.id)
  end

  describe "User Story 12 through 14" do
    it "has all information for particular application" do
      visit "/admin/applications/#{@new_application_1.id}"

      expect(page).to have_content("Application ##{@new_application_1.id}")
      expect(page).to have_content("#{@new_application_1.status}")
      expect(page).to have_content("Applicant Name: #{@new_application_1.name}")
      expect(page).to have_content ("Applicant's Address: #{@new_application_1.street_address}, #{@new_application_1.city}, #{@new_application_1.state} #{@new_application_1.zip_code}")
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_content("#{@pet_2.name}")
    end

    it "can allow admins to approve applications for particular pets that do not affect other pets" do
      visit "/admin/applications/#{@new_application_1.id}"

      expect(page).to have_button("Approve Pet")
      expect(page).to have_button("Reject Pet")
      expect(page).to_not have_content("Approved!")
      expect(page).to_not have_content("Denied Application.")
      
      click_button("Approve Pet", match: :first)

      expect(page).to have_content("Approved!")
      expect(page).to have_button("Reject Pet")
      expect(page).to have_button("Approve Pet")

      visit "/admin/applications/#{@new_application_2.id}"
      expect(page).to have_button("Approve Pet")
      expect(page).to have_button("Reject Pet")
      expect(page).to_not have_content("Approved!")
      expect(page).to_not have_content("Denied Application.")

      click_button("Approve Pet", match: :first)

      expect(page).to have_content("Approved!")
      expect(page).to have_button("Reject Pet")
      expect(page).to have_button("Approve Pet")
    end

    it "can allow admins to deny applications for particular pets that do not affect other pets" do
      visit "/admin/applications/#{@new_application_1.id}"

      expect(page).to have_button("Reject Pet")
      expect(page).to have_button("Approve Pet")
      expect(page).to_not have_content("Denied Application.")

      click_button("Reject Pet", match: :first)

      expect(page).to have_content("Denied Application.")
      expect(page).to have_button("Reject Pet")
      expect(page).to have_button("Approve Pet")
      

      visit "/admin/applications/#{@new_application_2.id}"

      expect(page).to have_button("Reject Pet")
      expect(page).to have_button("Approve Pet")
      expect(page).to_not have_content("Denied Application.")

      click_button("Reject Pet", match: :first)

      expect(page).to have_content("Denied Application.")
      expect(page).to have_button("Reject Pet")
      expect(page).to have_button("Approve Pet")
    end
  end
end
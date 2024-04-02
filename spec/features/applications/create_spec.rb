require "rails_helper"

RSpec.describe "application creation page" do

    it 'applications create page renders the form' do
        visit "/applications/new"

        expect(page).to have_content ("New Application")
        expect(find("form")).to have_content ("Street Address:")
        expect(find("form")).to have_content ("City:")
        expect(find("form")).to have_content ("State:")
        expect(find("form")).to have_content ("Zip")
        expect(find("form")).to have_content ("Why will this home be a good home for the pet(s)?")
    end

    it 'creates an application on submit' do
        visit "/applications/new"

        fill_in "name", with: "Grant"
        fill_in "street_address", with: "1234 Corner Lane"
        fill_in "city", with: "Longmont"
        fill_in "state", with: "CO"
        fill_in "zip_code", with: "808025"
        fill_in :description, with: "I like doggos."

        click_button "Submit Application"

        expect(page).to have_content("Grant")
        expect(page).to have_content("1234 Corner Lane, Longmont, CO 808025")
        expect(page).to have_content("I like doggos.")
    end

    it 'will error out when create form incorrectly filled out and redirects to new' do
        visit "/applications/new"

        click_button 'Submit Application'

        expect(page).to have_content("Error")
        expect(current_path).to eq("/applications/new")
    end
end
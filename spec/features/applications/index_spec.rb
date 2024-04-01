require "rails_helper"

RSpec.describe "applications index page" do

    it 'applications index lists all applications' do
        @new_application = Application.create!(name: "John Wing", street_address: "1234 Long St.", city: "Star", state: "CA", zip_code: "12545", description: "I have always loved dogs and would like to adopt one!", status: "In Progress")

        visit "/applications"

        within "#application_#{@new_application.id}" do
            expect(page).to have_content ("Applicant: John Wing")
        end
    end

end
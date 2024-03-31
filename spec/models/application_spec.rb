require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe '#initialize' do
    it 'application properly initializes' do
      @new_application = Application.create!(name: "John Wing", street_address: "1234 Long St.", city: "Star", state: "CA", zip_code: "12545", description: "I have always loved dogs and want more of them!", status: "In Progress")
      expect(@new_application.name).to eq("John Wing")
      expect(@new_application.street_address).to eq("1234 Long St.")
      expect(@new_application.city).to eq("Star")
      expect(@new_application.state).to eq("CA")
      expect(@new_application.zip_code).to eq("12545")
      expect(@new_application.description).to eq("I have always loved dogs and want more of them!")
      expect(@new_application.status).to eq("In Progress")
    end
  end

end
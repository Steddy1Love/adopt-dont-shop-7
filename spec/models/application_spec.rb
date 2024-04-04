require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
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

  it '#add_pet' do
    shelter = Shelter.create!(name: "Parker Animal Shelter", city: "Parker", rank: 4, foster_program: false)
    pet1 = Pet.create!(name: "Bear", age: 4, breed: "Malamute", adoptable: true, shelter_id: shelter.id)
    pet2 = Pet.create!(name: "Max", age: 8, breed: "Siberian Husky", adoptable: true, shelter_id: shelter.id)
    pet3 = Pet.create!(name: "Leo", age: 3, breed: "Golden Retriever", adoptable: true, shelter_id: shelter.id)
    app1 = Application.create!(name: "John Wing", street_address: "1234 Long St.", city: "Star", state: "CA", zip_code: "12545", description: "I have always loved dogs and would like to adopt one!", status: "In Progress")

    app1.add_pet(pet1.id)
    app1.add_pet(pet2.id)
    app1.add_pet(pet3.id)

    expect(app1.pets).to eq([pet1, pet2, pet3])
  end


end
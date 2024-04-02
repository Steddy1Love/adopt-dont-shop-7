class Application < ApplicationRecord

  validates :name, :street_address, :city, :state, :zip_code, :description, presence: true

  has_many :application_pets
  has_many :pets, through: :application_pets
  
  def self.pets_applying_for
    Pet.joins(application_pets: {application: :shelter}).distinct
  end

  def self.unique_list_pets(id)
    Pet.joins(:applications).distinct.where("application_id = ?", id)
  end

  def add_pet(pet_id)
    pet = Pet.find(pet_id)
    self.pets << pet
  end
end
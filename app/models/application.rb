class Application < ApplicationRecord

  validates :name, :street_address, :city, :state, :zip_code, :description, presence: true

  has_many :application_pets
  has_many :pets, through: :application_pets
  
  def self.pets_applying_for
    Pet.joins(application_pets: {application: :shelter}).distinct
  end

  def change_status(new_status)
    self.update(new_status)
  end
end
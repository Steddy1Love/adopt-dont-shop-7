class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  
  def self.pets_applying_for
    Pet.joins(application_pets: {application: :shelter}).distinct
  end

  def self.unique_list_pets(id)
    Pet.joins(:applications).distinct.where("application_id = ?", id)
  end
end
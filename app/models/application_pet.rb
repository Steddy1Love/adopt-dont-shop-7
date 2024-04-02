class ApplicationPet < ApplicationRecord

  belongs_to :pet
  belongs_to :application

  def self.change_status_to_approved(application_id, pet_id)
    @adoption_app_pet = ApplicationPet.where({pet_id: pet_id, application_id: application_id}).first
    @adoption_app_pet.change_app_pet_status("Approved")
  end

  def self.change_status_to_rejected(application_id, pet_id)
    @adoption_app_pet = ApplicationPet.where({pet_id: pet_id, application_id: application_id}).first
    @adoption_app_pet.change_app_pet_status("Rejected")
  end
end
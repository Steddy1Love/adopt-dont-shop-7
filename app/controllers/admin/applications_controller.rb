class Admin::ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @application_pets = ApplicationPet.find(@application.id, @pet_id)
  end

  def update
    application = Application.find(params[:id])

    if params.include? :approved_pet
        pet_id = params[:approved_pet]
        application_pet = ApplicationPet.where({pet_id: pet_id, application_id: application.id}).first
        application_pet.update(status: "Approved")

    elsif params.include? :rejected_pet
        pet_id = params[:rejected_pet]
        application_pet = ApplicationPet.where({pet_id: pet_id, application_id: application.id}).first
        application_pet.update(status: "Rejected")

    end
  end

end
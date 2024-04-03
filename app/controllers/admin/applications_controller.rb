class Admin::ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application_pets = []
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pets.each{|pet| binding.pry @application_pets << ApplicationPet.find_by(pet_id: pet.id, application_id: @application.id)}
  end

  def update
     binding.pry
     if params[:approved_pet].present?
      pet_id = params[:approved_pet]
      @application_pets = ApplicationPet.find(@application.id, pet_id)
      ApplicationPet.change_status_to_approved(@application.id, pet_id)
    elsif params[:rejected_pet].present?
      @application_pets = ApplicationPet.find(@application.id, pet_id)
      pet_id = params[:rejected_pet]
      ApplicationPet.change_status_to_rejected(@application.id, pet_id)
    end
  end
end
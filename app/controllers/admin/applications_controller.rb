class Admin::ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @application_pets = ApplicationPet.find(@application.id, pet_id)
  end

  def update
     binding.pry
     if params[:approved_pet].present?
      pet_id = params[:approved_pet]
      
      ApplicationPet.change_status_to_approved(@application.id, pet_id)
    elsif params[:rejected_pet].present?

      pet_id = params[:rejected_pet]
      ApplicationPet.change_status_to_rejected(@application.id, pet_id)
    end
  end
end
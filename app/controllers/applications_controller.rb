class ApplicationsController < ApplicationController
  def index
    @all_applications = Application.all
  end  
  
  def new
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pets2 = Pet.search(params[:search]) if params[:search].present?
  
    if params[:add_pet].present?
      pet_id = params[:add_pet]
      @application.add_pet(pet_id)

      redirect_to show_application_path(@application)
    end
  end
  
  def create
    @application = Application.new(application_params)
    if @application.save 
      redirect_to "/applications/#{@application.id}"
    else       
      flash[:notice] = "Error: #{error_message(@application.errors)}"
      redirect_to "/applications/new"
    end
  end

  private

  def application_params
    params
      .permit(:name, :street_address, :city, :state, :zip_code, :description)
      .with_defaults(status: "In Progress")
  end
end
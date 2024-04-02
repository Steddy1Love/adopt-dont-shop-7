class ApplicationsController < ApplicationController
  def index
    @all_applications = Application.all
  end  
  
  def new
  end

  def show
    @application = Application.find(params[:id])
    @app = Application.unique_list_pets(@application.id)
  
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = []
    end
  end
  

  def create
    @application = Application.new(application_params)
      if @application.save 
        redirect_to "/applications/#{@application.id}"
    else       
        flash.now[:alert] = "Error: #{error_message(@application.errors)}"
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
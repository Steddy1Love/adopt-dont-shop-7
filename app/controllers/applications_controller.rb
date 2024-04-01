class ApplicationsController < ApplicationController
  def index
    @all_applications = Application.all
  end  
  
  def new
  end

  def show
    @application = Application.find(params[:id])
    @app = Application.unique_list_pets(@application.id)
  end

  def create
    @application = Application.create!(applications_params)

    redirect_to "/applications/#{@application.id}"
  end

  private

  def applications_params
    params
        .permit(:name, :street_address, :city, :state, :zip_code, :description)
        .with_defaults(status: "In Progress")
  end
end
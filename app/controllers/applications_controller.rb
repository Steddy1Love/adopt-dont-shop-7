class ApplicationsController < ApplicationController
  def new
  end

  def show
    @application = Application.find(params[:id])
    @app = Application.unique_list_pets(@application.id)
  end

  def create
    Application.create!(applications_params)

    redirect_to "/application/:id"
  end

  private

  def applications_params
    params_permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
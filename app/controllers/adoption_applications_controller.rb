class AdoptionApplicationController < ApplicationController
  def index
    @adoption_applicatons = Application.all
  end

  def new
  end

  def create
    adoption_app = AdoptionApplication.new(adoption_application_params)
  end

  private 

  def adoption_application_params
    params.permit(:name,
                  :street_address,
                  :city,
                  :state,
                  :zip_code,
                  :description)
  end

end
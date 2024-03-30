class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @app = Application.unique_list_pets(@application.id)
  end
end
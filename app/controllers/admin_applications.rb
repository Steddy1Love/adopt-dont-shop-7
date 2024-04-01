class AdminApplications < ApplicationController
  def index
    
  end

  def show
    @app_admin = Application.find(params[:id])
  end
  
end
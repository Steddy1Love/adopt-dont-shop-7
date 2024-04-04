class Admin::SheltersController < ApplicationController
  def index
    @admin_shelters = Shelter.with_admin
    @pending_app_shelters = Shelter.with_pending_apps
  end
end

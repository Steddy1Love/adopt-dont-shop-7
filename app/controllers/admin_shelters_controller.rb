class AdminSheltersController < ApplicationController
    def index
      @admin_shelters = Shelter.find_by_sql("SELECT name FROM shelters ORDER BY shelters.name DESC;")
      @pending_app_shelters = Shelter.with_pending_apps
      @pending_app_shelters = Shelter.joins(:applications).where("applications.status = 'Pending'").distinct
    end
end

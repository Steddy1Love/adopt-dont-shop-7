class AdminController < ApplicationController
    def index
        @admin_shelters = Shelter.find_by_sql("SELECT name FROM shelters ORDER BY shelters.name DESC;")
    end

    # Shelter.joins(:applications).where("applications.status = 'Pending'").dist inct;
end

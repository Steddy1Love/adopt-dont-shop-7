class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
      
  def self.search(query_params)
    where("name ILIKE ?", "%#{query_params}%")
  end
end

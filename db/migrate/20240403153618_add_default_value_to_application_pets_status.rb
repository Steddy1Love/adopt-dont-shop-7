class AddDefaultValueToApplicationPetsStatus < ActiveRecord::Migration[7.1]
  def change
    change_column :application_pets, :status, :string, default: "In Progress"
  end
end

class AddOwnerDescriptionToApplication < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :owner_description, :string
  end
end

class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  has_many :applications, through :pets
end
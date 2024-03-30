class ApplicationPet < ApplicationRecord

  belongs_to :pet
  belongs_to :application
  has_many :shelters, through: :pets

end
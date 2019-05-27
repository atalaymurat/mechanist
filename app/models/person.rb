class Person < ApplicationRecord
  has_many :connected
  has_many :companies, through: :connected
  validates :first_name, presence: true, length: { minimum: 3 }
  belongs_to :user

  def full_name
    full_name = self.first_name.capitalize + " " + self.middle_name.capitalize + " " + self.last_name.upcase
  end

end 

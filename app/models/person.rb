class Person < ApplicationRecord
  has_many :connected, dependent: :destroy
  has_many :companies, through: :connected
  has_many :emails, dependent: :destroy
  validates :first_name, presence: true, length: { minimum: 2 }
  belongs_to :user
  accepts_nested_attributes_for :emails, allow_destroy: true,  reject_if: proc { |attributes| attributes['email'].blank? }
 

  def full_name
    full_name = self.first_name.capitalize + " " + self.middle_name.capitalize + " " + self.last_name.upcase
  end

end 

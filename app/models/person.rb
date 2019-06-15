class Person < ApplicationRecord
  has_many :connected, dependent: :destroy
  has_many :companies,-> {distinct}, through: :connected
  has_many :emails, dependent: :destroy
  has_many :phones, dependent: :destroy
  validates :first_name, presence: true, length: { minimum: 2 }
  belongs_to :user
  accepts_nested_attributes_for :emails, allow_destroy: true,  reject_if: proc { |attributes| attributes['email'].blank? }
  accepts_nested_attributes_for :phones, allow_destroy: true, reject_if: proc { |attributes| attributes['phone_number'].blank? }

 

  def full_name
    full_name = self.first_name.capitalize + " " + self.middle_name.capitalize + " " + self.last_name.upcase
  end

end 

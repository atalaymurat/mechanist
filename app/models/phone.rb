class Phone < ApplicationRecord
  belongs_to :person
  validates :phone_number, numericality: {only_integer: true}, length: {minimum: 10}
end

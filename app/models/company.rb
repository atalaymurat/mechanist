class Company < ApplicationRecord
  has_many :people
  accepts_nested_attributes_for :people, update_only: true, reject_if: proc { |attributes| attributes['first_name'].blank? }
end

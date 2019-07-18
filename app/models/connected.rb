class Connected < ApplicationRecord
  belongs_to :person
  belongs_to :company
  before_save :default_values
  validates_uniqueness_of :position, scope: [:person_id, :company_id], message: "can not be some position in same company"

  def default_values
    self.position = "Employee" if self.position.nil?
  end

end

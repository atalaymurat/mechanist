class Connected < ApplicationRecord
  belongs_to :person
  belongs_to :company
  before_save :default_values

  def default_values
    self.position = "Employee" if self.position.nil?
  end

end

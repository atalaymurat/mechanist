class Person < ApplicationRecord
  belongs_to :company, optional: true

  def full_name
    full_name = "#{self.first_name.capitalize} #{self.middle_name.capitalize} #{self.last_name.upcase}"
  end

end

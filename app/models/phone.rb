class Phone < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :company, optional: true
  validates :phone_number, format: {with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/ }, length: {minimum: 10, maximum: 17}, uniqueness: true
  before_save :default_values

  def default_values
    self.phone_type = "Mobile" if self.phone_type.nil?
  end

end

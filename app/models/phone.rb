class Phone < ApplicationRecord
  belongs_to :person
  validates :phone_number, format: {with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/ }, length: {minimum: 10, maximum: 17}
end

class Email < ApplicationRecord
  belongs_to :person
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, allow_nil: true, allow_blank: true

  belongs_to :user
end

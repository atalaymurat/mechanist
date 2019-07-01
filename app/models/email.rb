class Email < ApplicationRecord
  belongs_to :person
  validates :email, uniqueness: true, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  belongs_to :user
end

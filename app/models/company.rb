class Company < ApplicationRecord
  has_many :people
  validates :name, presence: true, length: { minimum: 3 }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, allow_nil: true
  belongs_to :user

  accepts_nested_attributes_for :people, update_only: true, reject_if: proc { |attributes| attributes['first_name'].blank? }
  mount_uploader :logo, ImageUploader
end

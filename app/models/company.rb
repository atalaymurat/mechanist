class Company < ApplicationRecord
  has_many :connected
  has_many :people, through: :connected
  validates :name, presence: true, length: { minimum: 3 }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, allow_nil: true, allow_blank: true
  belongs_to :user

  accepts_nested_attributes_for :people, allow_destroy: true, reject_if: proc { |attributes| attributes['first_name'].blank? }
  mount_uploader :logo, ImageUploader
end

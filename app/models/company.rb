class Company < ApplicationRecord
  has_many :connected, dependent: :destroy
  has_many :people, -> {distinct}, through: :connected
  validates :name, presence: true, length: { minimum: 3 }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, allow_nil: true, allow_blank: true

  belongs_to :user
  belongs_to :country, optional: true
  belongs_to :state, optional: true

  delegate :name, to: :country, prefix: true, allow_nil: true
  delegate :name, to: :state, prefix: true, allow_nil: true

  accepts_nested_attributes_for :people, allow_destroy: true, reject_if: proc { |attributes| attributes['first_name'].blank? }
  accepts_nested_attributes_for :connected,allow_destroy: true, reject_if: proc { |attributes| attributes['person_id'].blank? }

  mount_uploader :logo, ImageUploader
  paginates_per 15

end

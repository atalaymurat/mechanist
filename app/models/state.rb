class State < ApplicationRecord
  belongs_to :country

  validates :country, presence: true
end

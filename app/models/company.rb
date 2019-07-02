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
  paginates_per 12

  require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      country_id = Country.find_by(alpha2: "#{row["Country"]}").id if row["Country"].present?
      state = State.where(country_id: country_id).find_by(name: "#{row["State"]}").id if row["State"].present?
      company_attributes = Hash.new
      company_attributes = {id: row["Id"],
                            name: (row["Name"].downcase if row["Name"].present?), 
                            country_id: country_id, 
                            state_id: state, 
                            town: (row["Town"].downcase if row["Town"].present?) , 
                            address_line: (row["Address_line"].downcase if row["Address_line"].present?), 
                            zip: row["Zip"], 
                            email: row["Email"], 
                            url: row["Url"], 
                            user_id: 2,
                            source: ((row["Source"].downcase if row["Source"].present?) or "makinaTR"),
                            note: (row["Note"].downcase if row["Note"].present?),
                            invoice_title: (row["Invoice"].downcase if row["Invoice"].present?)
                          }
      puts company_attributes
      company = Company.where(id: row["Id"])
        if company.present?
          company.first.update_attributes!(company_attributes)
          puts "#{row["Name"].upcase} updated.."
        else
          puts "trying to create #{company.name}"
          Company.create!(company_attributes)
          puts "#{row["Name"].upcase} created.."
        end
    end
  end
end

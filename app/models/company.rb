class Company < ApplicationRecord
  has_many :connected, dependent: :destroy
  has_many :people, -> {distinct}, through: :connected
  has_many :phones, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, allow_nil: true, allow_blank: true

  belongs_to :user
  belongs_to :country, optional: true
  belongs_to :state, optional: true

  delegate :name, to: :country, prefix: true, allow_nil: true
  delegate :name, to: :state, prefix: true, allow_nil: true

  accepts_nested_attributes_for :people, allow_destroy: true, reject_if: proc { |attributes| attributes['first_name'].blank? }
  accepts_nested_attributes_for :connected, allow_destroy: true, reject_if: proc { |attributes| attributes['person_id'].blank? }
  accepts_nested_attributes_for :phones, allow_destroy: true, reject_if: proc { |attributes| attributes['phone_number'].blank? }

  mount_uploader :logo, ImageUploader

  require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      country_id = Country.find_by(alpha2: "#{row["Country"]}").id if row["Country"].present?
      state = State.where(country_id: country_id).find_by(name: "#{row["State"]}").id if row["State"].present?
      company_attributes = Hash.new
      company_attributes = {id: row["Id"],
                            name: (row["Name"].mb_chars.downcase if row["Name"].present?), 
                            country_id: country_id, 
                            state_id: state, 
                            town: (row["Town"].mb_chars.downcase if row["Town"].present?) , 
                            address_line: (row["Address_line"].mb_chars.downcase if row["Address_line"].present?), 
                            zip: row["Zip"], 
                            email: row["Email"], 
                            url: row["Url"], 
                            user_id: 2,
                            source: ((row["Source"].mb_chars.downcase if row["Source"].present?) or "makinaTR"),
                            note: (row["Note"].mb_chars.downcase if row["Note"].present?),
                            invoice_title: (row["Invoice"].mab_chars.downcase if row["Invoice"].present?)
                          }
      puts company_attributes
      company = Company.where(id: row["Id"])
        if company.present?
          company.first.update_attributes!(company_attributes)
          puts "#{row["Name"].mb_chars.upcase} updated.."
        else
          puts "trying to create #{company.name}"
          Company.create!(company_attributes)
          puts "#{row["Name"].mb_chars.upcase} created.."
        end
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      column_names << 'person_ids'
      column_names << 'phones'
      names = column_names
      csv << names
      all.each do |company|
        row = company.attributes.values_at(*column_names)
        row << company.person_ids
        row << company.phones.to_ary
        csv << row
      end
    end
  end


end

class Person < ApplicationRecord
  has_many :connected, dependent: :destroy
  has_many :companies,-> {distinct}, through: :connected
  has_many :emails, dependent: :destroy
  has_many :phones, dependent: :destroy
  validates :first_name, presence: true, length: { minimum: 1 }
  belongs_to :user
  accepts_nested_attributes_for :emails, allow_destroy: true,  reject_if: proc { |attributes| attributes['email'].blank? }
  accepts_nested_attributes_for :phones, allow_destroy: true, reject_if: proc { |attributes| attributes['phone_number'].blank? }

  def full_name
    full_name = "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end

  require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      person_attributes = Hash.new
      person_attributes = {
        id: row["Id"],
        first_name: (row["First_name"].mb_chars.downcase if row["First_name"].present?),
        middle_name: (row["Middle_name"].mb_chars.downcase if row["Middle_name"].present?),
        last_name: (row["Last_name"].mb_chars.downcase if row["Last_name"].present?),
        company_ids: [row["Company_ids"]],
        note: (row["Note"].mb_chars.downcase if row["Note"].present?),
        user_id: 2,
        source: "makinaTR"
      }
      person = Person.where(id: row["Id"])
      if person.present?
        person.first.update_attributes!(person_attributes)
        puts "Existing Person #{row["Id"]} Updated"
      else
        person.create!(person_attributes)
        puts "New person created #{row["Id"]}"
      end
      my_person = Person.find(row["Id"])
      if my_person.emails.new({email: row["Email"], user_id: 2}).valid? and row["Email"].present?
        my_person.emails.create!({email: row["Email"], user_id: 2})
      end
      if my_person.emails.new({email: row["Email1"], user_id: 2}).valid? and row["Email1"].present?
        my_person.emails.create!({email: row["Email1"], user_id: 2})
      end
      if my_person.emails.new({email: row["Email2"], user_id: 2}).valid? and row["Email2"].present?
        my_person.emails.create!({email: row["Email2"], user_id: 2})
      end
      if my_person.phones.new({phone_number: row["Gsm"]}).valid? and row["Gsm"].present?
        my_person.phones.create!({phone_type: "Mobile", phone_number: row["Gsm"]})
      end
      if my_person.phones.new({phone_number: row["Phone_work"]}).valid? and row["Phone_work"].present?
        my_person.phones.create!({phone_type: "Work", phone_number: row["Phone_work"]})
      end
      if my_person.phones.new({phone_number: row["Phone_work2"]}).valid? and row["Phone_work2"].present?
        my_person.phones.create!({phone_type: "Work", phone_number: row["Phone_work2"]})
      end
    end
  end
end 

class AddPeopleToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :people, foreign_key: true
  end
end

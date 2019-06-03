class AddColumnsToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :country, foreign_key: true
    add_reference :companies, :state, foreign_key: true
  end
end

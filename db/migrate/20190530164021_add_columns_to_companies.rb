class AddColumnsToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :country, foreign_key: true
    add_reference :companies, :state, foreign_key: true
    add_column :companies, :address_line, :text
    add_column :companies, :town, :string
    add_column :companies, :zip, :string
    add_column :companies, :address_title, :string
  end
end

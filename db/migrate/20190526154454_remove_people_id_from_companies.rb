class RemovePeopleIdFromCompanies < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :people_id, :integer
  end
end

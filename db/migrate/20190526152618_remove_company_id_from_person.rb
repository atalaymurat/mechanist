class RemoveCompanyIdFromPerson < ActiveRecord::Migration[5.2]
  def change
    remove_column :people, :company_id, :integer
  end
end

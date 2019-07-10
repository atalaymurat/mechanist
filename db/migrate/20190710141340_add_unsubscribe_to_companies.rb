class AddUnsubscribeToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :unsubscribe, :boolean
  end
end

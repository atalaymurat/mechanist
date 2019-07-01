class AddSourceToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :source, :string
  end
end

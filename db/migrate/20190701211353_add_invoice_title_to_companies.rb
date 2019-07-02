class AddInvoiceTitleToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :invoice_title, :text
  end
end

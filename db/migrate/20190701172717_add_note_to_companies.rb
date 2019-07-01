class AddNoteToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :note, :text
  end
end

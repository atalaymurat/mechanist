class AddCompanyToPhones < ActiveRecord::Migration[5.2]
  def change
    add_reference :phones, :company, foreign_key: true
  end
end

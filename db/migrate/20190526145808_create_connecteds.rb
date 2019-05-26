class CreateConnecteds < ActiveRecord::Migration[5.2]
  def change
    create_table :connecteds do |t|
      t.references :person, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end

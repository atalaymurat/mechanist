class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :name
      t.string :alpha2
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end

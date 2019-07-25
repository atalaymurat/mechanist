class CreateMachines < ActiveRecord::Migration[5.2]
  def change
    create_table :machines do |t|
      t.references :brand, foreign_key: true
      t.references :category, foreign_key: true
      t.string :model_type
      t.integer :model_year
      t.string :condition
      t.integer :price
      t.boolean :published
      t.references :user, foreign_key: true
      t.json :images

      t.timestamps
    end
  end
end

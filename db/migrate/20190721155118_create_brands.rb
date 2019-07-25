class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :image
      t.string :url
      t.string :ancestry

      t.timestamps
    end
    add_index :brands, :ancestry
  end
end

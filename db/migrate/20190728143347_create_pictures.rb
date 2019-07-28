class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.references :machine, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end

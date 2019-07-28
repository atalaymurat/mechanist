class RemoveImagesFromMachines < ActiveRecord::Migration[5.2]
  def change
    remove_column :machines, :images, :json
  end
end

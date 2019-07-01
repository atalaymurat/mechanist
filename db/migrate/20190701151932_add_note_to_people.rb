class AddNoteToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :note, :text
  end
end

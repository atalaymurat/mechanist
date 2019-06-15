class AddPositionToConnecteds < ActiveRecord::Migration[5.2]
  def change
    add_column :connecteds, :position, :string
  end
end

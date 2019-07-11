class AddUserPictureToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_picture, :string
  end
end

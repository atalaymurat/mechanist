class AddUnsubscribeToEmails < ActiveRecord::Migration[5.2]
  def change
    add_column :emails, :unsubscribe, :boolean
  end
end

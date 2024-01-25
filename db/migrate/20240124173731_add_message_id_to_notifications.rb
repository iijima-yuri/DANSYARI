class AddMessageIdToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :message_id, :integer
  end
end

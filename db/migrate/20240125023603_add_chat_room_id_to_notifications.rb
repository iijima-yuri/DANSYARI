class AddChatRoomIdToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :chat_room_id, :integer
  end
end

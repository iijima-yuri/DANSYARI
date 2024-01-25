class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  has_many :notifications, dependent: :destroy

  after_create_commit { MessageBroadcastJob.perform_later self }

  def create_notification_chat(current_user, message_id, room_id, visited_id)
    temp_ids = Message.select(:user_id).where(room_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_chat(current_user, message_id, temp_id['user_id'])
    end
    save_notification_chat(current_user, message_id, visited_id) if temp_ids.blank?
  end

  def save_notification_chat(current_user, message_id, visited_id)
    notification = current_user.active_notifications.new(message_id: id, visited_id: visited_id, action: 'chat')

    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end

class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.chat_room_id}", { message: render_message(message) }
  end

  private

  def render_message(message)
    ApplicationController.render(partial: 'chat_rooms/message', locals: { message: })
  end
end

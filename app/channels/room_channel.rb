class RoomChannel < ApplicationCable::Channel
  include ActionController::Cookies

  def subscribed
    stream_from "room_channel_#{params['chat_rooms']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! message: data['message'], user_id: current_user.id, chat_room_id: params['chat_rooms']
  end
end

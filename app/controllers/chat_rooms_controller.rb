class ChatRoomsController < ApplicationController
  before_action :require_login

  def entrance
    @followers = current_user.followers
  end

  def show
    target_user_have_chat_room_ids = Entry.where(user_id: params[:id]).pluck(:chat_room_id)
    current_user_have_chat_room_ids = Entry.where(user_id: current_user.id).pluck(:chat_room_id)
    target_chat_room_id = (target_user_have_chat_room_ids & current_user_have_chat_room_ids)
    @chat_room = ChatRoom.find(target_chat_room_id.first)
    if Entry.where(user_id: current_user.id, chat_room_id: @chat_room.id).present?
      @messages = @chat_room.messages
      @entries = @chat_room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
end

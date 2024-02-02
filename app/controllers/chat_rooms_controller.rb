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

  def create
    current_user.follow(params[:user_id])
    ActiveRecord::Base.transaction do
      @chat_room = ChatRoom.create(name: "DM")
      Entry.create(user_id: current_user.id, chat_room_id: chat_room.id)
      Entry.create(user_id: params[:user_id], chat_room_id: chat_room.id)
    end
    User.find(params[:user_id]).create_natification_follow(current_user)
    redirect_to request.referer
  end
end

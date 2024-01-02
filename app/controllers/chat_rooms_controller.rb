class ChatRoomsController < ApplicationController
  before_action :require_login

  def index
    @user = current_user
    @currentEntries = current_user.entries
    myChatRoomIds = []
    @currentEntries.each do |entry|
      myChatRoomIds << entry.chat_room.id
    end
    @anotherEntries = Entry.where(chat_room_id: myChatRoomIds).where.not(user_id: @user.id).order(created_at: :desc)
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    if Entry.where(user_id: current_user.id, chat_room_id: @chat_room.id).present?
      @messages = @chat_room.messages
      @entries = @chat_room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @chat_room = ChatRoom.create(name: "DM")
    @entry1 = Entry.create(chat_room_id: @chat_room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :chat_room_id).merge(chat_room_id: @chat_room.id))
    redirect_to chat_room_path(@chat_room.id)
  end

  def destroy
    chat_room = ChatRoom.find(params[:id])
    chat_room.destroy
    redirect_to chat_rooms_path
  end
end

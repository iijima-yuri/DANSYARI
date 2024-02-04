class RelationshipsController < ApplicationController
  before_action :require_login

  def create
    current_user.follow(params[:user_id])
    ActiveRecord::Base.transaction do
      @chat_room = ChatRoom.create(name: "DM")
      Entry.create(user_id: current_user.id, chat_room_id: @chat_room.id)
      Entry.create(user_id: params[:user_id], chat_room_id: @chat_room.id)
    end
    User.find(params[:user_id]).create_notification_follow(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:id])
    @users = user.following_users
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_users
  end
end

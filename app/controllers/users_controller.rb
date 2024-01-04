class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]
  def new
    @user = User.new
  end

  def index
    @followeds = current_user.followers
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, info: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
      @msg = "他のユーザーとチャットしてみよう！"
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.chat_room_id == u.chat_room_id then
            @isChatRoom = true
            @chatRoomId = cu.chat_room_id
          end
        end
      end
      if @isChatRoom != true
        @chat_room = ChatRoom.new
        @entry = Entry.new
      end
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:item_id)
    @favorite_items = Item.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :salt, :name, :icon)
  end
end

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
      session[:user_id] = @user.id
      redirect_to items_path, info: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
      @msg = "他のユーザーとチャットしてみよう！"
    else
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.chat_room_id == u.chat_room_id
            @is_chat_room = true
            @chat_room_id = cu.chat_room_id
          end
        end
      end
      if @is_chat_room != true
        @chat_room = ChatRoom.new
        @entry = Entry.new
      end
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:item_id)
    @favorite_items = Item.where(id: favorites).order(created_at: :desc).page(params[:page]).per(6)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :salt, :name, :icon)
  end
end

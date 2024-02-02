class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]
  def new
    @user = User.new
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

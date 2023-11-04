class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create new destroy]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, notice: 'ログインに成功しました'
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path, success: t('.success')
  end
end

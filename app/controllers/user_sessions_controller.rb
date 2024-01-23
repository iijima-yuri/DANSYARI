class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create new]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to items_path, info: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:info] = t('.success')
    redirect_to root_path, status: :see_other
  end
end

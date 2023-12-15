class Mypage::ProfilesController < Mypage::BaseController
  before_action :set_user, only: %i[edit update]

  def show
    @user = current_user
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to mypage_profile_path, info: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now[:error] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :icon, :icon_cache)
  end
end
class Mypage::ProfileShowsController < Mypage::BaseController

  def show
    @user = User.find(params[:id])
  end
end
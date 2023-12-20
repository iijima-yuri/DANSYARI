class Mypage::ProfileShowsController < Mypage::BaseController
  def show
    @user = User.find(params[:id])
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end
end

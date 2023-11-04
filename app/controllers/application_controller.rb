class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_autheticated
    redirect_to login_path, danger: "ログインしてください"
  end
end

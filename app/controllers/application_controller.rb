class ApplicationController < ActionController::Base
  before_action :require_login

  add_flash_types :error, :warn, :info

  private

  def not_authenticated
    redirect_to login_path, warn: t('defaults.message.require_login')
  end
end

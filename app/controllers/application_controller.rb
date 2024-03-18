class ApplicationController < ActionController::Base
  before_action :require_login

  add_flash_types :error, :warn, :info

  rescue_from StandardError, with: :render500
  rescue_from ActiveRecord::RecordNotFound, with: :render404

  def render404(error = nil)
    Rails.logger.error("❌#{error.message}") if error
    render 'errors/error404', status: :not_found
  end

  def render500(error = nil)
    Rails.logger.error("❌#{error.message}") if error
    render 'errors/error500', status: :internal_server_error
  end

  private

  def not_authenticated
    redirect_to login_path, warn: t('defaults.message.require_login')
  end
end

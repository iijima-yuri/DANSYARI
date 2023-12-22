class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(11)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end

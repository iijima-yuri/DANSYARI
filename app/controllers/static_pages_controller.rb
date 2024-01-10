class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:top]
  def top
    @q = Item.ransack(params[:q])
  end
end

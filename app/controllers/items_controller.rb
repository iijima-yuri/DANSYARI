class ItemsController < ApplicationController
  def index
    @items = Item.all.includes(:user).order(created_at: :desc)
  end
end

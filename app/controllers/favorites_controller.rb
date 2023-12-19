class FavoritesController < ApplicationController
  def create
    @item_favorite = Favorite.new(user_id: current_user.id, item_id: params[:item_id])
    @item_favorite.save
    redirect_to item_path(params[:item_id])
  end

  def destroy
    @item_favorite = Favorite.find_by(user_id: current_user.id, item_id: params[:item_id])
    @item_favorite.destroy
    redirect_to item_path(params[:item_id])
  end
end

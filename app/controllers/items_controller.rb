class ItemsController < ApplicationController
  def index
    @items = Item.published.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      redirect_to items_path, success: t('defaults.message.created', item: Item.model_name.human)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :episode_content, :reason_content, :item_image, :item_image_cache, :reason_status, :status)
  end
end

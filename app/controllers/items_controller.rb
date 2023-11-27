class ItemsController < ApplicationController
  before_action :set_item, only: %i[edit update destroy]

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
    @comment = Comment.new(commentable: @item)
    @comments = @item.comments.includes(:user).order(created_at: :desc)
  end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to @item, success: t('defaults.message.updated', item: Item.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.updated', item: Item.model_name.human)
      render :edit
    end
  end

  def destroy
    @item.destroy!
    redirect_to items_path, success: t('defaults.message.deleted', item: Item.model_name.human)
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :episode_content, :reason_content, :item_image, :item_image_cache, :reason_status, :status)
  end
end

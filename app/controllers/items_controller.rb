class ItemsController < ApplicationController
  before_action :set_item, only: %i[edit update destroy]

  def index
    @items = Item.published.includes(:user, :genre).order(created_at: :desc).page(params[:page]).per(6)
    @tag_list = Tag.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = current_user.items.new(item_params)
    tag_list = params[:item][:tag_list].split(',')
    if @item.save
      @item.save_tags(tag_list)
      redirect_to items_path, info: t('defaults.message.created', item: Item.model_name.human)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @comment = Comment.new(commentable: @item)
    @comments = @item.comments.includes(:user).order(created_at: :desc)
    @tag_list = @item.tags.pluck(:name).join(',')
    @item_tags = @item.tags
    @genre = @item.genre
  end

  def edit
    @tag_list = @item.tags.pluck(:name).join(',')
    @genres = Genre.all
  end

  def update
    tag_list = params[:item][:tag_list].split(',')
    if @item.update(item_params)
      @item.save_tags(tag_list)
      redirect_to items_path, info: t('defaults.message.updated', item: Item.model_name.human)
    else
      flash.now[:error] = t('defaults.message.not_updated', item: Item.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy!
    redirect_to items_path, info: t('defaults.message.deleted', item: Item.model_name.human)
  end

  def trashed_items
    @trashed_items = current_user.items.where(reason_status: 'trash')
  end

  def stay_items
    @stay_items = current_user.items.where(reason_status: 'stay')
  end

  def worry_items
    @worry_items = current_user.items.where(reason_status: 'worry')
  end

  def all_items
    @all_items = current_user.items
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @items = @tag.items
  end

  def search_genre
    @genre_list = Genre.all
    @genre = Genre.find(params[:genre_id])
    @items = @genre.items
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :episode_content, :reason_content, :item_image, :item_image_cache, :reason_status, :status, :genre_id)
  end
end

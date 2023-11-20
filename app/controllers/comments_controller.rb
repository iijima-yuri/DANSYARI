class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to item_path(comment.item), success: t('defaults.message.created', item: Comment.model_name.human)
    else
      redirect_to item_path(comment.item), danger: t('defaults.message.created', item: Comment.model_name.human)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(item_id: params[:item_id])
  end
end

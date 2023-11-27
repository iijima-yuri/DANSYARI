class CommentsController < ApplicationController
  before_action :find_commentable, only: %i[create]


  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.item_id = @comment.commentable_id

    respond_to do |format|
      if @comment.save
        format.turbo_stream { flash.now[:success] = t('defaults.message.created', item: Comment.model_name.human) }
        format.html { redirect_to @comment.commentable, flash: { success: t('defaults.message.created', item: Comment.model_name.human) } }
      else
        format.turbo_stream do
          flash.now[:danger] = t('defaults.message.not_created', item: Comment.model_name.human)
          render turbo_stream: [
            turbo_stream.replace("flash_messages", partial: "shared/flash_messages")
          ]
        end
        format.html { redirect_to @comment.commentable, flash: { danger: t('defaults.message.not_created', item: Comment.model_name.human) } }
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.turbo_stream { flash.now[:success] = t('defaults.message.destroyed', item: Comment.model_name.human) }
      format.html { redirect_to @comment.commentable, flash: { success: t('defaults.message.destroyed', item: Comment.model_name.human) } }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :item_id).merge(user_id: current_user.id)
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @commentable = ::Regexp.last_match(1).classify.constantize.find(value)
        return @commentable
      end
    end
    nil
  end
end

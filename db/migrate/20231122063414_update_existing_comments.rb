class UpdateExistingComments < ActiveRecord::Migration[7.1]
  def up
    Comment.where(commentable_type: nil).update_all(commentable_type: " ")
    Comment.where(commentable_id: nil).update_all(commentable_id: 0)
  end
end

class AddCommentableToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :commentable, polymorphic: true, null: true
  end
end

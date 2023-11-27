class AddNotNullConstraintToComments < ActiveRecord::Migration[7.1]
  def change
    change_column :comments, :commentable_type, :string, null: false
    change_column :comments, :commentable_id, :bigint, null: false
  end
end

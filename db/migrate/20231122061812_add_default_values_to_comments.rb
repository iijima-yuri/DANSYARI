class AddDefaultValuesToComments < ActiveRecord::Migration[7.1]
  def change
    change_column :comments, :commentable_type, :string, default: " "
    change_column :comments, :commentable_id, :bigint, default: 0
  end
end

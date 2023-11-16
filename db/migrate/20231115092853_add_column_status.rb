class AddColumnStatus < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :status, :integer, null: false, default: 0
  end
end

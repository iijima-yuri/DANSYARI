class AddColumnReasonStatus < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :reason_status, :integer, null: false, default: 0, comment: '理由のステータス'
  end
end

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :episode_content, null: false
      t.text :reason_content, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

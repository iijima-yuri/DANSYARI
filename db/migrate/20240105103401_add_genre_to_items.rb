class AddGenreToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :genre, null: false, foreign_key: { to_table: :genres }
  end
end

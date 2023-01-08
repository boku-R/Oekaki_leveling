class CreateLinedrawFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :linedraw_favorites do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :linedraw_illust_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end

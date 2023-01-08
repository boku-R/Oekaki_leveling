class CreateColorFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :color_favorites do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :color_illust_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end

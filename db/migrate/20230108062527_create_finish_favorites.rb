class CreateFinishFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :finish_favorites do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :finish_iluust_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end

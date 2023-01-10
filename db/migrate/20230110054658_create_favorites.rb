class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :illust_id, foreign_key: true, null: false
      t.integer :illust_step, null: false

      t.timestamps
    end
  end
end

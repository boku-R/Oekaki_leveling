class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.boolean :is_deleted, null: false, default: false
      t.string :title, null: false
      t.string :introduction
      t.timestamps
    end
  end
end

class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :post_id, foreign_key: true, null: false
      t.string :comment, null:false
      t.boolean :is_deleted, null: false, default: false

      t.timestamps
    end
  end
end

class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.integer :post_id, foreign_key: true, null: false
      t.integer :tag_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end

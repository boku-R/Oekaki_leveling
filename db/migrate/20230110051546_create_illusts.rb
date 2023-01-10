class CreateIllusts < ActiveRecord::Migration[6.1]
  def change
    create_table :illusts do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :post_id, foreign_key: true, null: false
      t.integer :step, null: false

      t.timestamps
    end
  end
end

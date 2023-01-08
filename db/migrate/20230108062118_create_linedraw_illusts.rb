class CreateLinedrawIllusts < ActiveRecord::Migration[6.1]
  def change
    create_table :linedraw_illusts do |t|
      t.integer :post_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end

class EditUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_deleted, :boolean, null: false, default: false
    add_column :users, :username, :string, null: false
    add_column :users, :handlename, :string, null: false
    add_column :users, :level, :integer, null: false, default: 1
  end
end

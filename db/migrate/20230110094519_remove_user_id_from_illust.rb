class RemoveUserIdFromIllust < ActiveRecord::Migration[6.1]
  def change
    remove_column :illusts, :user_id, :integer
  end
end

class RemoveIllustStepFromFavorite < ActiveRecord::Migration[6.1]
  def change
    remove_column :favorites, :illust_step, :integer
  end
end

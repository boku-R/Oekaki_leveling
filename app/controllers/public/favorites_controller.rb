class Public::FavoritesController < ApplicationController

  def create
    # いいねをつける機能
    @post = Post.find(params[:post_id])
    @illust = Illust.find(params[:illust_id])
    favorite = current_user.favorites.new(illust_id: @illust.id)
    favorite.save

    # レベルを計算してuserに投入
    user = @post.user
    level = get_level(user)
    user.update(level: level)
  end

  def destroy
    # いいねをつける機能
    @post = Post.find(params[:post_id])
    @illust = Illust.find(params[:illust_id])
    favorite = current_user.favorites.find_by(illust_id: @illust.id)
    favorite.destroy

    # レベルを計算してuserに投入
    user = @post.user
    level = get_level(user)
    user.update(level: level)
  end

  private

  # ユーザのイラストに対するいいねの総数(経験値:exp)を計算し、レベルを算出
  def get_level(user)
    exp = 0
    level = 1
    # 経験値の計算
    user.posts.each do |f|
      f.illusts.each do |i|
        if i.illust_image.present?
          exp += i.favorites.count
        end
      end
    end
    # 経験値が、レベルアップに必要な経験値以上になるまでwhile文が回ります
    while exp >= 10*(1.2**level)
      level += 1
    end
    return level
  end

end

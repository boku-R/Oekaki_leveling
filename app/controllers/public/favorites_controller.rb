class Public::FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    illust = Illust.find(params[:illust_id])
    favorite = current_user.favorites.new(illust_id: illust.id)
    # favorite = current_user.favorites.new(illust_id: post.id)
    favorite.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    illust = Illust.find(params[:illust_id])
    favorite = current_user.favorites.find_by(illust_id: illust.id)
    favorite.destroy
    redirect_to post_path(post)
  end

end
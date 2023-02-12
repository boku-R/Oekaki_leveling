class Public::RelationshipsController < ApplicationController
  # フォローする
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
  end

  # フォローを外す
  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
  end

  # フォロー一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.where(is_deleted: false).page(params[:users_page])
  end
  # フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.where(is_deleted: false).page(params[:users_page])
  end
end

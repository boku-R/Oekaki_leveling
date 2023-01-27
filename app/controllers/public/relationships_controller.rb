class Public::RelationshipsController < ApplicationController
  # フォローする
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  # フォローを外す
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.where(is_deleted: false).page(params[:page])
  end
  # フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.where(is_deleted: false).page(params[:page])
  end
end

class Admin::UsersController < ApplicationController
  # 管理者だけが管理者機能を使えるようにする
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def index
    # 論理削除されたものを含む全ての投稿、使われていないタグもすべて表示
    @users = User.all.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # フラッシュメッセージを設定
      flash[:notice] = "ユーザ情報は編集されました"
      render :edit
    else
      @user.profile_image.blob = User.find(params[:id]).profile_image.blob
      flash[:notice] = "ユーザ情報を編集できませんでした"
      render :edit
    end
  end

  private

  # Userのストロングパラメータ
  def user_params
    params.require(:user).permit(:email, :is_deleted, :username, :handlename, :profile_image, :password)
  end

end

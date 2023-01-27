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
      # ユーザを管理者権限で論理削除した際、関連する投稿も全て論理削除する
      if @user.is_deleted == true
        @user.posts.update(is_deleted: true)
      end
      # フラッシュメッセージを設定
      flash[:notice] = "ユーザ情報は編集されました"
      redirect_to admin_user_path(@user)
    else
      @user.profile_image.blob = User.find(params[:id]).profile_image.blob
      flash[:notice] = "ユーザ情報を編集できませんでした"
      redirect_to admin_user_path(@user)
    end
  end

  private

  # Userのストロングパラメータ
  def user_params
    params.require(:user).permit(:email, :is_deleted, :username, :handlename, :introduction, :profile_image, :password)
  end

end

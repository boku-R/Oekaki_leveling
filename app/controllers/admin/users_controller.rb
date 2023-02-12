class Admin::UsersController < ApplicationController
  # 管理者だけが管理者機能を使えるようにする
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:posts_page])

    @draft_favorite_count = favorites_count(@user,"draft")
    @linedraw_favorite_count = favorites_count(@user,"linedraw")
    @color_favorite_count = favorites_count(@user,"color")
    @finish_favorite_count = favorites_count(@user,"finish")
  end

  def index
    # 論理削除されたものを含む全ての投稿、使われていないタグもすべて表示
    @users = User.all.page(params[:users_page])
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
      render :edit
    end
  end

  private

  # Userのストロングパラメータ
  def user_params
    params.require(:user).permit(:email, :is_deleted, :username, :handlename, :introduction, :profile_image, :password)
  end

  # 特定の段階のイラストに対するいいねの数を計算する
  def favorites_count(user,step)
    count = 0
    user.posts.each do |f|
      count += f.illusts.find_by(step: step).favorites.count
    end
    return count
  end

end

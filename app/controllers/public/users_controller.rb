class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit, :unsubscribe]
  # ログインしていない状態のアクセスを制限する
  before_action :authenticate_user!
  before_action :ensure_current_user, only: [:edit, :update, :unsubscribe]

  def show
    @user = User.where(is_deleted: false).find(params[:id])
    @posts = @user.posts.where(is_deleted: false).page(params[:posts_page])

    @draft_favorite_count = favorites_count(@user,"draft")
    @linedraw_favorite_count = favorites_count(@user,"linedraw")
    @color_favorite_count = favorites_count(@user,"color")
    @finish_favorite_count = favorites_count(@user,"finish")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # フラッシュメッセージを設定
      flash[:notice] = "ユーザ情報は編集されました"
      redirect_to user_path(@user)
    else
      # ここでユーザアイコン画像を格納することでバリデーションエラーを収納
      @user.profile_image.blob = User.find(params[:id]).profile_image.blob
      render :edit
    end
  end

  def favorites
    @user = User.find(params[:id])
    # ユーザがいいねしたイラストのIDを「favorites」インスタンスに格納
    favorites = Favorite.where(user_id: @user.id).pluck(:illust_id)
    # 対応するPostが論理削除されていない、かつidが上記の「favorites」を探し出している
    @favorite_illusts = Illust.joins(:post).where(id: favorites, posts: { is_deleted: false }).page(params[:posts_page])
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    # ユーザが退会するとき、関連するすべての投稿も論理削除する
    @user.posts.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


  private

  # Userのストロングパラメータ
  def user_params
    params.require(:user).permit(:email, :is_deleted, :username, :handlename, :introduction, :profile_image)
  end

  # ゲストユーザでログインしているとき、ユーザ編集ができないようにする
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.username == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面、もしくは退会画面へ遷移できません。'
    end
  end

  # ログイン中のユーザと、ユーザページで表示しているユーザが異なるときの権限の設定
  def ensure_current_user
    if current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to user_path
    end
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

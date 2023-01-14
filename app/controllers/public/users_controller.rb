class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit, :unsubscribe]
  before_action :ensure_current_user, only: [:edit, :update, :unsubscribe]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # @user.valid?
    if @user.update(user_params)
      # フラッシュメッセージを設定
      flash[:notice] = "ユーザ情報は編集されました"
      redirect_to user_path
    else
      # @user = User.find(params[:id])
      @user.profile_image.blob = User.find(params[:id]).profile_image.blob
      flash[:notice] = "ユーザ情報を編集できませんでした"
      render :edit
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:illust_id)
    @favorite_illusts = Illust.find(favorites)
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


  private

  # Userのストロングパラメータ
  def user_params
    params.require(:user).permit(:email, :is_deleted, :username, :handlename, :profile_image)
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

end
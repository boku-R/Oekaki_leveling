# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # ゲストログインのための記述
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user),notice:'guest userでログインしました'
  end

  protected

  # 退会しているか判断するためのメソッド
  def customer_state
    # 入力されたusernameから、該当のアカウントを特定
    @user = User.find_by(username: params[:user][:username])
    # アカウントが見つからなかったら、このメソッドを終了
    return if !@user
    # もしパスワードが正しく(true)、退会フラグがtrueの場合、新規登録画面に遷移
    if @user.valid_password?(params[:user][:password]) && @user.is_deleted
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_user_registration_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

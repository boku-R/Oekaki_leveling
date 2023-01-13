class ApplicationController < ActionController::Base
  # ログインしていない状態では、トップページとアバウトページしか閲覧できない
  before_action :authenticate_user!, except: [:top, :about]
  # deviseによる会員登録にて、ユーザ名とハンドルネームを登録させる
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    # ユーザ登録（sign_up）の際に、データ操作を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :handlename])

    # ログイン登録（sign_in）の際に、データ操作を許可
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])

    # アカウント編集の時に諸々のストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :encrypted_password, :is_deleted, :username, :handlename, :profile_image])
  end
end

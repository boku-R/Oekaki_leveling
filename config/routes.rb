Rails.application.routes.draw do

  # ユーザのログインに関する記述
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者のログインに関する記述
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # ゲストログインのための記述
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # public のネームスペース
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    resources :posts, only: [:index, :show, :create, :edit, :update, :destroy, :new] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
        get :favorites
      end
    end
    get 'users/:id/favorites' => 'users#favorites' , as: 'favorites'
    # 退会画面
    get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch 'users/:id/withdrawal' => 'users#withdrawal' , as: 'withdrawal'
    get 'search' => 'searches#search'
    # タグを押すと、そのタグに関連づけられた投稿を表示するためのルーティング
    get 'search_tag' => "posts#search_tag"
  end

  # admin　のネームスペース
  namespace :admin do
    root to: 'homes#top'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

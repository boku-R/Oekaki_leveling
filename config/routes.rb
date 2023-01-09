Rails.application.routes.draw do

  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  # 顧客用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # public のネームスペース
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    resources :posts, only: [:index, :show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    get 'users/:id/favorites' => 'users#favorites' , as: 'favorites'
    patch 'users/:id/withdraw' => 'users#withdraw' , as: 'withdraw'
    get 'search' => 'searches#search'
  end

  # admin　のネームスペース
  namespace :admin do
    root to: 'homes#top'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

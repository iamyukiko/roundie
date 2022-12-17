Rails.application.routes.draw do

#会員用Devise
  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/passwords'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

#管理者用Devise
  devise_for :admin, skip: [:registrations,:passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :admin do
    post 'admin/guest_sign_in', to: 'admin/sessions#guest_sign_in'
  end


#会員用ルーティング
  scope module: :public do
  root to: 'homes#top'
  get '/about' => "homes#about", as: "about"

  resources :users, only:[:show, :edit, :update, :unsubscribe] do
    resource :relationships, only:[:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
  get '/users/:user_id/events/applies' => "applies#index", as: 'index_apply'
  patch '/users/:user_id/events/:event_id/applies/:id' => "applies#update", as: 'update_apply'
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  patch '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
  get 'users/:id/activities' => 'activities#index', as: 'index_activities'
  patch 'users/:id/activities/:id/read' => 'activities#read', as: 'read_activities'
  resources :messages, only:[:create,]
  resources :rooms, only:[:create, :show, :index]
  resources :events do
    get "join" => "events#join"
  end

  resources :events, only:[:new, :create, :index, :show, :destroy] do
    resources :event_comments, only:[:create]
  end

  end

#管理者用ルーティング
  scope module: :admin do
  get '/admin' => "homes#top"
  get "admin/search" => "searches#search"
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :events, only: [:index, :show, :edit, :update]
  end

end

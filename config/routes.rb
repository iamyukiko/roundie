Rails.application.routes.draw do

  #会員用Devise
  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/passwords'
  }

  #管理者用Devise
  devise_for :admin, skip: [:registrations,:passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  #会員用ルーティング
  scope module: :public do
  root to: 'homes#top'
  get '/about' => "homes#about", as: "about"
  resources :users, only:[:show, :edit, :update, :unsubscribe] do
    resource :relationships, only:[:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
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
  end

end

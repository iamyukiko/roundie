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
  resources :users, only:[:show, :edit, :update, :unsubscribe]
  resources :events do
    get "join" => "events#join"
  end
  end

  #管理者用ルーティング
  scope module: :admin do
  get '/admin' => "homes#top"
  end

end

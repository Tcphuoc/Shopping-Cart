Rails.application.routes.draw do
  devise_for :shop,
             controllers: { sessions: 'shop/sessions', registrations: 'shop/registrations',
                            passwords: 'shop/passwords' }
  devise_for :users,
             controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
                            passwords: 'users/passwords' }
  authenticated :shop do
    root 'admin/products#index', as: :admin_root
  end
  
  get '/home', to: 'pages#home'
  root 'pages#home'
  resources :products, param: :slug
  resources :carts, only: [:index, :new, :update]
  resources :categories, param: :slug
  resources :search, only: [:index]
  resources :orders, only: [:index, :new, :create, :destroy]

  namespace :admin do
    resources :products, param: :slug
    resources :categories, param: :slug
    resources :orders, only: [:index]
    post '/products', to: 'products#filter'
    post '/categories', to: 'categories#filter'
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  match '*unmatched', to: 'application#render404', via: :all
end

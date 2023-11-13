Rails.application.routes.draw do
  devise_for :shop,
             controllers: { sessions: 'shop/sessions', registrations: 'shop/registrations',
                            passwords: 'shop/passwords' }
  devise_for :users,
             controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
                            passwords: 'users/passwords' }
  get '/home', to: 'pages#home'
  get 'pages/about'
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
    post '/filter/product', to: 'filter#filter_product'
    post '/filter/category', to: 'filter#filter_category'
  end

  match '*unmatched', to: 'application#route_not_found', via: :all

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end

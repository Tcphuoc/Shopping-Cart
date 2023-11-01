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
  resources :carts, only: [:index, :update]
  resources :categories, param: :slug
  resources :search, only: [:index]
  post :search, to: 'search#search'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end

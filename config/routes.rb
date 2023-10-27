Rails.application.routes.draw do
  devise_for :shop, controllers: { sessions: 'shop/sessions', passwords: 'shop/passwords' }
  devise_for :users,
             controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
                            passwords: 'users/passwords' }
  get '/home', to: 'pages#home'
  get 'pages/about'
  root 'pages#home'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end

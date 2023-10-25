Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_up', to: 'users/registrations#new'
  end
  get '/home', to: 'pages#home'
  get 'pages/about'
  root 'pages#home'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  get '/home', to: 'pages#home'
  get 'pages/about'
  root 'pages#home'
end

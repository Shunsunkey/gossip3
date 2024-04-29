Rails.application.routes.draw do
  root 'static_pages#accueil'
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  get 'welcome/:first_name', to: 'static_pages#welcome', as: 'welcome'
  resources :gossips
  resources :users, only: [:show]
end

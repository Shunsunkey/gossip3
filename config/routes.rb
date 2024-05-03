Rails.application.routes.draw do
  root 'static_pages#index'
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  get '/welcome', to: 'static_pages#welcome'
  get '/static_page', to: 'static_pages#index', as: 'static_pages_index'
  post '/like/:gossip_id', to: 'likes#like', as: 'like_gossip'
  delete '/unlike/:gossip_id', to: 'likes#unlike', as: 'unlike_gossip'  
  delete '/logout', to: 'sessions#destroy', as: 'logout' # Ajout de la route de déconnexion
  resources :gossips do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :users, only: [:new, :create, :show] # Ajout de la ressource pour les utilisateurs
  resources :cities, only: [:show]
  resources :tags, only: [:show]
  resources :sessions, only: [:new, :create, :destroy] # Correction du nom du contrôleur de sessions
end

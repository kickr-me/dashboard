Rails.application.routes.draw do
  root 'dashboard#index'
  resources :match_teams
  resources :teams
  resources :rounds
  resources :matches
  resources :players
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

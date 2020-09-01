Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#home'
  resources :songs, only: %i(show)
  resources :user_settings, only: %i(create)
end

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#home'
  resources :songs, only: %i(show)
  resources :settings do
    post :create_setting_user
    delete :destroy_setting_user
  end
end

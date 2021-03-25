Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'auth/spotify/callback', to: 'authentications#create', as: :provider_callback
  post 'auth/guest', to: 'authentications#create'
  resources :player, only: :create
  
  resources :users, only: :show do
    collection do
      resources :scores, only: %i[index create], module: :users
    end
  end
end

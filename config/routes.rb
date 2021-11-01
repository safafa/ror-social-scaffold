Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :create] do
        resources :comments, only: [:create, :index]
      end
    end 
  end
  get 'friendships/create'
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    post "/friendship/confirm", to: "friendships#confirm"
    delete "friendship/reject", to: "friendships#reject"
    delete "friendship/remove", to: "friendships#remove"
    resources :friendships
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

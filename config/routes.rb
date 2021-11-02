Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      post :auth, to: "authentication#create"
      resources :posts, only: [:index, :create] do
        resources :comments, only: [:create, :index]
      end
    end 
  end
  get 'friendships/create'
  root 'posts#index'

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

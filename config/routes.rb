Shooring::Application.routes.draw do
  root 'activities#index'

  resources :users
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  delete "/signout", to: "sessions#destroy", as: "signout"

  resources :activities do
    resources :folders
  end

  resources :folders do
    resources :comments
  end

  resources :files

  namespace :admin do
    root :to => "base#index"
    resources :users do
      resources :permissions

      put "permissions", to: "permissions#set", as: "set_permissions"
    end
  end
end

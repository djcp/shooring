Shooring::Application.routes.draw do
  root 'activities#index'

  resources :users
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"

  resources :activities do
    resources :folders
  end

  namespace :admin do
    root :to => "base#index"
    resources :users
  end
end

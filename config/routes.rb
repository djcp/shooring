Shooring::Application.routes.draw do
  root 'activities#index'

  resources :users

  resources :activities do
    resources :folders
  end

end

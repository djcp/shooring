Shooring::Application.routes.draw do
  root 'activities#index'

  resources :activities
end

Shooring::Application.routes.draw do
  root 'activities#index'

  resources :activities do
    resources :folders
  end

end

Diggit::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'songs#index'
  resources :songs do
    resources :comments
  end

  resources :users

  post '/users/login', to: 'users#login'
  post '/users/logout', to: 'users#logout'

end

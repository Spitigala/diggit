Diggit::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'songs#index'
  resources :songs, except: [:edit, :update] do
    member do
      post 'upvote'
      post 'downvote'
    end
    resources :comments do
      member do
        post 'upvote'
        post 'downvote'
      end
    end
  end

  resources :users, except: [:index, :edit, :update] do
    member do
      post 'login'
      post 'logout'
    end
  end

  post '/users/login', to: 'users#login'
  post '/users/logout', to: 'users#logout'

end

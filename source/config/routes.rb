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
    resources :comments, except: [:index, :show, :new] do
      member do
        post 'upvote'
        post 'downvote'
      end
    end
  end

  get 'users/signout' => 'users#signout'
  resources :users, except: [:index, :edit, :update]
  post 'users/signin' => 'users#signin'
  # resources :sessions, only: [:create, :destroy]

  # post '/users/login', to: 'users#login'
  # post '/users/logout', to: 'users#logout'
  # post 'sessions/new', to: 'sessions#create'
  # post 'sessions/destroy', to: 'sessions#destroy'

end

Hub::Engine.routes.draw do
  resources :topics, path: 't', only: [:index, :show, :destroy] do
    resources :people, path: 'p', only: [] do
      patch :follow, :unfollow
    end
    member do
      get :like_received
      post :reply
      patch :like, :unlike
    end
    collection do
      get :feed
    end
  end
  resources :people, path: 'p', only: [:show, :index] do
    member do
      get :participant_topics
      get :following, :followers
      patch :follow, :unfollow
    end
  end
  resources :notifications, path: 'n', only: [] do
    collection do
      get :liker
      get :follower
      get :reply
      get :system
    end
  end
end

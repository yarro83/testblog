Easyblog::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :posts do
    resources :comments, only: [:create, :vote_up, :vote_down, :mark_as_not_abusive] do
      member do
        post :vote_up
        post :vote_down
        post :mark_as_not_abusive
      end
    end
    member do
      post :mark_archived
    end
  end
end

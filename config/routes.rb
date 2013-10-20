Easyblog::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :posts do
    resources :comments, only: [:create]
    member do
      post :mark_archived
    end
  end
end

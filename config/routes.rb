Rails.application.routes.draw do
  root 'sessions#new'

  resource :user, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]
  resources :subs, except: [:destroy] do
    resources :posts, only: [:new, :create]
  end
  resources :posts, except: [:index, :new, :create] do
    resources :comments, only: [:new, :create]
  end
  resources :comments, only: [:edit, :update] do
    resources :comments, only: [:new, :create]
  end
end

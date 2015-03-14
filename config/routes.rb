Rails.application.routes.draw do
  get 'comment/new'

  get 'comment/edit'

  root 'sessions#new'

  resource :user, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]
  resources :subs, except: [:destroy] do
    resources :posts, only: [:new, :create]
  end
  resources :posts, except: [:index, :new, :create]

end

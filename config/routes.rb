Maia::Application.routes.draw do
  resources :debates
  resources :answers,         only: [:create]
  resources :tags,            only: [:create]
  resources :objections,      only: [:create]
  resources :justifications,  only: [:create]
  resources :votes,           only: [:create]
  resources :sessions,        only: [:new, :create, :destroy]
  resources :users do
    get :autocomplete_user_name, :on => :collection
  end
  resources :users_relationships, only: [:create, :destroy]
  resources :conversations,       only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  
  root 'static_pages#home'
  match '/help',                    to: 'static_pages#help',     via: 'get'
  match '/about',                   to: 'static_pages#about',    via: 'get'
  match '/signup',                  to: 'users#new',             via: 'get'
  match '/signin',                  to: 'sessions#new',          via: 'get'
  match '/signout',                 to: 'sessions#destroy',      via: 'delete'
  match 'auth/:provider/callback',  to: 'sessions#oauth_login',  via: 'get'

end

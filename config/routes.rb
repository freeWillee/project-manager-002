Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new'

  # Sessions
    #Facebook Omniauth login
  get '/auth/facebook/callback' => 'sessions#fblogin'
  get '/login' => "sessions#new"
  post '/sessions' => "sessions#create"
  get '/logout' => "sessions#destroy"

  #Projects
  resources :projects, only: [:show] do
    resources :tasks, only: [:new, :create, :edit, :update]
  end

  #Tasks
  resources :tasks, only: [:new, :create, :edit, :update, :show]

  #Users, nested tasks
  resources :users, only: [:show, :edit, :update] do
    resources :tasks, only: [:index, :show]
    resources :projects, only: [:index, :show]
  end

  # Admin tasks
  namespace :admin do
    resources :users
    resources :projects
    resources :tasks
  end
end

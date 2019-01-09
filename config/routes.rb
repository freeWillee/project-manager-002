Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new'

  # New user
  get '/signup' => "users#new"

  # Sessions
  get '/login' => "sessions#new"
  post '/sessions' => "sessions#create"
  get '/logout' => "sessions#destroy"

  #Projects
  resources :projects, only: [:index, :new, :show] do
    resources :tasks, only: [:new, :create, :edit, :update]
  end

  #Tasks
  resources :tasks, only: [:new, :create, :edit, :update, :show]

  #Users, nested tasks
  resources :users, only: [:new, :index, :show, :edit, :update, :destroy, :create] do
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

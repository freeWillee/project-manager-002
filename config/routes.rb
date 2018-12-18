Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # New user
  get '/signup' => "users#new"

  # Sessions
  get '/login' => "sessions#new"
  post '/sessions' => "sessions#create"
  get '/logout' => "sessions#destroy"

  #Projects
  resources :projects, only: [:index, :new, :create, :edit, :update, :destroy, :show]

  # #Tasks
  resources :tasks, only: [:index, :new, :create, :edit, :update, :destroy, :show]

  #Users, nested tasks
  resources :users, only: [:new, :index, :show, :edit, :update, :destroy, :create] do
    resources :projects, only: [:show]
    resources :tasks, only: [:show]
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new'

  # test class method
  get '/tasks/show_tasks_by_user/'=> 'tasks#tasks_by_user'  
  
  #GET RID OF THIS LATER!!!!
  get '/tasks/almost_done'=> 'tasks#almost_done'

  # Sessions
    #Facebook Omniauth login
  get '/auth/facebook/callback' => 'sessions#fblogin'
  get '/login' => "sessions#new"
  post '/sessions' => "sessions#create"
  get '/logout' => "sessions#destroy"

  #Projects
  resources :projects, only: [:show] do 
    resources :tasks, only: [:index]
  end


  #Tasks
  resources :tasks, only: [:new, :create, :edit, :update, :show]

  #Users nested
  resources :users, only: [:new, :create, :show, :edit, :update] do
    resources :tasks, only: [:new, :create, :index, :show, :edit, :update]
    resources :projects, only: [:show, :index]
  end

  # Admin tasks
  namespace :admin do
    resources :users
    resources :projects do 
      resources :tasks, only: [:index]
    end
    resources :tasks
  end


end

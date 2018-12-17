Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/login' => "sessions#new"
  post '/sessions' => "sessions#create"

  get '/logout' => "sessions#destroy"

  scope '/admin' do
    resources :projects, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :users, only: [:index]
  end

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :projects, only: [:index, :show]
    resources :tasks, only: [:show, :edit, :update]
  end
end

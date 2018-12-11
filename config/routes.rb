Rails.application.routes.draw do
  get 'projects/index'
  get 'projects/new'
  get 'projects/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, only: [:index, :new, :create]
end

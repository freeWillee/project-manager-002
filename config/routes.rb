Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :admin do
    root to: 'projects#index'
    resources :projects
    resources :users, only:[:new, :create, :edit, :update, :destroy]
  end

  namespace :users do
    resources :projects, only: [:index]
  end
end

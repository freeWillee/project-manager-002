Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/admin' do
    resources :projects, only: [:index, :new, :create, :edit, :update, :destroy, :show]
    resources :users, only:[:new, :create, :edit, :update, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    resources :projects, only: [:index, :show]
    resources :tasks, only: [:show, :edit, :update]
  end
end

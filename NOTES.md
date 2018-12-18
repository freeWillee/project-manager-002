1. projects
  index => Show all Projects

  routes:
    get '/projects', to: 'projects#index'
    get '/projects/new', to: 'projects#new'
    get '/projects/delete', to: 'projects#delete'
    get '/projects/create', to: 'projects#create'

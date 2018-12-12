1. projects
  index => Show all Projects

  routes:
    get '/admin/projects', to: 'projects#index'
    get '/admin/projects/new', to: 'projects#new'
    get '/admin/projects/delete', to: 'projects#delete'
    get '/admin/projects/create', to: 'projects#create'
    

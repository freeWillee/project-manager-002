# Specifications for the Rails Assessment

Specs:

- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
  - A user has many tasks
  - A project has many tasks
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
  - A task belongs to a user
  - A task belongs to a project
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
  - A user has many projects through tasks
  - A project has many users through tasks
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
  - a task has many users
  - a task has many projects
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
        - A task has the following user submittable attributes when a task is created (by a user):
            1) task name
            2) task details
            3) task completion status
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
    The following validations are setup in this application:

        User:

        Must have a unique username
        Must have a unique email
        Task:

        Must have a title
        Project:

        Must have a name
        Must have a deadline that is not in the past

- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
    Model object: Task
    Class method name: by_user
    Class method url: /tasks/show_tasks_by_user
- [x] Include signup (how e.g. Devise)
        The signup is done through the admin page as only the user can create a new user.  
- [x] Include login (how e.g. Devise)
        The login page is the default page.
- [x] Include logout (how e.g. Devise)
        The logout button is available on the navbar for users and admin.
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
        Using omniauth, a user can sign up as a new user, or login to an existing account (from the login page)
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
        Nested resources as follows:
        resources :users, only: [:show, :edit, :update] do
                resources :tasks, only: [:new, :create, :index, :show, :edit, :update]
                resources :projects, only: [:show]
        end
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
        See above.
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
        Validation errors are collected and flash message sent through layouts.

Confirm:

- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
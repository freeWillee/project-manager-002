# Project Manager

This application is a mini project management system for project administrators to be able to create, modify, add, and delete projects.  Within each project will be a series of tasks that can be assigned to any number of users.  Users, in turn, will have the ability to update the status of any task that is assigned to them.  

The genesis of this project came from discussions with various project managers that had many projects on the go with multiple tasks and users to manage.  Every user could be involved in multiple projects and to keep track of all of the moving parts was difficult.  Also there needed to be a medium in which a user would be able to communicate with a project manager at anytime in the least amount of steps and vice versa.  Each day, too much time is spent determining where each project is, which matters are urgent when each project is due, etc.  This application is a first step in attempting to meet the goal of being a one stop place to manage a project manager and individual team members' workload.

As you can imagine, there are an infinite number of features that can be implemented, but for the purposes of this project, I have decided to focus on the following key points:

1)The project manager is the 'admin' user that can control everything about the project, including user login credentials (over time this should simplified, and delegated accordingly, mostly because it  would be too easy to accidentally delete database entries).
2)Only the admin can add and destroy projects.
3)A user can create his or her own account on Facebook; before the user can start anything, an admin must assign them to a project.
4)An admin may not necessarily know which project to assign a task to (e.g. they just thought of a task that needs to be done but doesn't know who to assign to or if the task will overlap with multiple projects, etc.).  In this case, the admin can use an "unsorted project".
5)After a project has been assigned, a user (not an admin) can go into the project and add or edit their own tasks to that specific project.  The user can only add to or edit a task of a project that they are already assigned to.

This first version of this project manager app will be accessed through a webpage, complete with login credentials required to access a user’s page.  The user’s page will show a list of projects assigned to the user, and the tasks under each project.  

With the assistance of the Omniauth gem, users will be able to login their account using Facebook.  Future versions and updates to this project will allow for login using Google, Twitter, or other popular social media platforms.

A note about the current version:

To limit the possibility of scope-creep, I have intentionally left out certain functions.  For example, in the first version of this application, only the admin user account is able to fully CRUD projects and tasks.  In the future, a user will be able to access these features as long as they are granted 'admin' status on their user account.  Another feature is the use of filters and sorting.  While this iteration of the project only allows for the filtering of users for a particular task, a feature in the future will allow for a user to quickly sort through existing tasks on their dashboard by project deadlilne or task completion status.  This feature would also be useful for the admin user to see.

** The code is a work in progress.  Suggestions on how to improve user functionality is welcome. **

## Installation

Simply fork and clone the repository to your local drive.

And then execute:

    bundle

## Usage

LOGIN/SIGNUP:
Verifications are in place to ensure that if a user tries to create a login with a username that already exists in the database, the user is presented with error messages indicating as such.  A user can create a username and password by clicking on the signup link on the main page, or login via Facebook.

If the admin account is user, the top of the page will indicate as such, otherwise a user sees their project dashboard page showing the following:
1.Outstanding tasks
2.Current projects

Default login for admin
 1.username: admin
 2.password: password

Users can also click on Login with Facebook link to create a new user profile.

EDITING:
1.A user can edit their profile from their dashboard.
2.A user can edit or add tasks when a project is assigned to them.
3.An admin user can CRUD any project, tasks, and users.

DELETING:
1.Only admin users are able to delete and destroy any user, project, or tasks.  You can find this action in the user/task/project show page.

LOGOUT:
1.To logout, simply click the logout link to return to the login page.

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/freeWillee/project-manager_001> This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

TO SUBMIT PULL REQUEST:
1) Fork and clone the repo: git clone git@github.com:freeWillee/project-manager_001.git
2) Make changes
3) Add tests for changes if possible
4) Push to your local fork and submit pull request: <https://github.com/freeWillee/project-manager_001/pulls>

** Please allow for at least 3 business days before receiving a response.  Please write tests for changes and write good commit messages.**

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in this project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/freeWillee/project-manager_001/blob/master/CODE_OF_CONDUCT.md).

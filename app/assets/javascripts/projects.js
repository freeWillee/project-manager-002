$(function() {
    // document ready
    bindClickHandlers()
});

const bindClickHandlers = () => {
    // listen for "Projects Dashboard link click" in nav bar
    $('.all_projects').on('click', (e) => {
        e.preventDefault()
        // Update URL
        history.pushState(null, null, "/admin/projects")
        //EXTRACT OUT FETCH STATEMENTS --> USE getPost()
        showProjectIndex()
    })

    // listen for show project link on projects index page
    $(document).on('click', '.show_link', function(e) {
        e.preventDefault()
        
        let id = $(this).attr('data-id')
        history.pushState(null, null, `/admin/projects/${id}`)
        showProject(id)
    })

    // listen for show more link on projects index page
    $(document).on('click', ".js-show-more", function(e) {
        e.preventDefault();
        const projectId = parseInt($(this).attr("data-id"));
        const projectDiv = $(`.more-project-overview-${projectId}`)
        if (projectDiv.text() === "") {
            showTaskSummary(projectId)
            this.innerText = "Show Less"
        } else {
            $(projectDiv).text("")
            this.innerText = "Show More"
        }
    })
    // listen for next button click on project show page
    $(document).on('click', ".next-project-btn", function() {
        let id = parseInt($(this).attr('data-id'))
        history.pushState(null, null, `/admin/projects/${id}`)
        getNextProject(id)        
    })

    // listen for previous button click on project show page
    $(document).on('click', ".previous-project-btn", function() {
        let id = parseInt($(this).attr('data-id'))
        history.pushState(null, null, `/admin/projects/${id}`)
        getPreviousProject(id)      
    })

    // listen for new task button click
    $(document).on('click', ".new-task-btn", function(e) {
        e.preventDefault();
        if ($(".new-task-form").text() === "") {
            createNewTaskForm()
            $(".new-task-btn").text("Hide New Task")
        } else {
            $(".new-task-form").text("")
            $(".new-task-btn").text("New Task")
        }

        
    })
}

const createNewTaskForm = () => {
    fetch('/admin/users.json')
    .then(res => res.json())
    .then(function(users) {
        let userCollection = []
        let formHTML = `
        <h2><strong>New Task</strong></h2>
        <form action="/admin/tasks" method="post">      
            <label for="task_user_id">Assignee: </label>
            <select name="task[user_id]" id="task_user_id">
        `
        users.forEach(user => {
            let newUser = new User(user)
            userCollection.push(newUser)
        })

        userCollection.forEach(user => {
            formHTML += `
                <option value="${user.id}">${user.username}</option>
            `
        })

        formHTML += `
            </select><br>
    
            <label for="task_title">Title</label><br>
            <input placeholder="Enter a title" class="form-control" type="text" name="task[title]" id="task_title">
    
            <label for="task_content">Content</label><br>
            <textarea placeholder="Task details" class="form-control" name="task[content]" id="task_content"></textarea>
    
            <label for="task_percent_complete">Percent complete</label><br>
            <input placeholder="Enter a number 1-100" class="form-control" type="text" value="0" name="task[percent_complete]" id="task_percent_complete">
    
            <input type="submit" name="commit" value="Create Task" data-disable-with="Create Task"><br>
            </form>
        `
        $('.new-task-form').append(formHTML)
    })
}

const showProjectIndex = () => {
    fetch('/admin/projects.json')  // this returns a promise.. use .then() to do stuff after...
    .then(res => res.json())
    .then(projects => {
        $('#app-container').html("")
        // repaint the DOM
        let pageHTML =  '<div class="section-container"><h1>Project List</h1></div>'
        let counter = 1
        projects.forEach(project => {
            let newProject = new Project(project)
            pageHTML += newProject.overview(counter)
            counter++
        })
        $('#app-container').append(pageHTML)
    })
}

const showProject = function(id) {
    fetch(`/admin/projects/${id}.json`)
    .then(res => res.json())
    .then(project => {
        let jsProject = new Project(project)
        let showProjectHTML = jsProject.show()
        $('#app-container').html("")
        $('#app-container').append(showProjectHTML)
    })
}

const showTaskSummary = function(projectId) {
    fetch(`/admin/projects/${projectId}.json`)
    .then(res => res.json())
    .then(project => {
        let jsProject = new Project(project)
        let tasks = jsProject.tasks
        let tasksHTML = '<div class="project-index-tasks"><h4>Tasks: </h4>'
        let counter = 1
        tasks.forEach(task => {
            tasksHTML += `
                <a href="/admin/tasks/${task.id}"><p>${counter}. ${task.title}</p></a>
            `
            counter ++
        })
        tasksHTML += "</div>"
        $(`.more-project-overview-${projectId}`).append(tasksHTML)
    })
}

const getNextProject = function(projectId) {
    fetch(`/admin/projects/${projectId}/next`)
    .then(res => res.json())
    .then(project => {
        let jsProject = new Project(project)
        let showProjectHTML = jsProject.show()
        $('#app-container').html("")
        $('#app-container').append(showProjectHTML)
    })
}

const getPreviousProject = function(projectId) {
    fetch(`/admin/projects/${projectId}/previous`)
    .then(res => res.json())
    .then(project => {
        let jsProject = new Project(project)
        let showProjectHTML = jsProject.show()
        $('#app-container').html("")
        $('#app-container').append(showProjectHTML)
    })
}

// Constructor function / no class
function Project(project) {
    this.id = project.id
    this.name = project.name
    this.deadline = project.deadline
    this.users = project.users.map(user => new User(user))
    this.tasks = project.tasks.map(task => new Task(task))
}

// Create some prototypes
Project.prototype.overview = function(counter){
    let projectHTML = `
        <div class="section-container">
            <a href="/admin/projects/${this.id}" data-id="${this.id}" class="show_link"><h4>${counter}. ${this.name}</h4></a>
            <a href="#" class="js-show-more" data-id="${this.id}"><p>Show more</p></a>
            <div class="more-project-overview-${this.id}"></div>
        </div>
    `
    return projectHTML
}   

Project.prototype.show = function(){
    let tasks = this.tasks
    let users = this.users
    let showProjectHTML = `
        <div class="project-nav-div">
            <button class="previous-project-btn" data-id="${this.id}"><< Previous Project</button>
            <button class="next-project-btn" data-id="${this.id}">Next Project >></button>        
        </div>
        <div class="section-container">
            <h3>Project Name: ${this.name}</h3>
            <h4><a href="/admin/projects/${this.id}/edit">Edit Project</a></h4>
            <h3>Deadline: ${new Date(this.deadline).toLocaleString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })}</h3>
        </div>
        <div class="section-container">
            <h3>Project Tasks</h3>
            <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Assignee</th>
                    <th>Percent Complete</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            `
    tasks.forEach(task => {
        const taskUser = users.find( user => user.id === task.user_id)
        showProjectHTML += `
            <tr>
                <td><a href="/admin/tasks/${task.id}">${task.title}</a></td>
                <td>${taskUser.username} (<a href="mailto: ${taskUser.email}">email</a>)</td>
                <td>${task.percent_complete}</td>
                <td><a href="/admin/tasks/${task.id}/edit">Edit</a></td>
            </tr>
        ` 
    })
    showProjectHTML += `
        </tbody>
        </table>
        <br>
        <p><button class="new-task-btn" data-id="${this.id}">New Task</button></p>
        <div class="new-task-form"></div>
        </div>
    `
    return showProjectHTML
}   
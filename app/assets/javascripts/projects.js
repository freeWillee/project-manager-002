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
            $(this).text.innerText = "Show Less"
        } else {
            $(projectDiv).text("")
            $(this).text.innerText = "Show More"
        }
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
        </div>
    `
    return showProjectHTML
}   
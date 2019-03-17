$(function() {
    // document ready
    listenForClick()
});

function listenForClick() {
    $(".js-overview").on('click', function(event){
        event.preventDefault();
        const projectId = $(this).data("id")
        // If user clicks on link content appear / disappear depending on whether or not there is content already shown.
        if (projectContainerForId(projectId).innerText === "") {
            getProject(projectId)
        } else {
            clearContainer(projectId)
        }
    })
}

function getProject(projectId) {
    const baseUrl = 'http://localhost:3000/admin/projects/' + projectId
    // make a request to the server - api -> project list
    $.ajax({
        url:baseUrl,
        method: 'GET',
        dataType: 'json'
    }).done( function(data) {
        // console.logging data to test
            console.log("this is the data returned: ", data)
        let theProject = new Project(data)
            console.log("this is the created project JS object: ", theProject)

        let projectHTML = theProject.postHTML()
            console.log("this is the HTML to append: ", projectHTML)

        document.querySelector(`#project-overview-container-${theProject.id}`).innerHTML = projectHTML
    })
}

class Project {
    constructor(obj) {
        this.id = obj.id
        this.name = obj.name
        this.deadline = obj.deadline
        this.tasks = obj.tasks.map(e => new Task(e))
        this.users = obj.users.map(e => new User(e))
    }
}

Project.prototype.postHTML = function () {
    return (`
        <div style="text-align: left;">
            <p><strong>Tasks:</strong></p>
            ${taskTitleHTML(this.tasks)}
            <p># of people: ${this.users.length}</p>
        </div>
    `)
}

function taskTitleHTML(taskObj) {    
    let taskHTML = "<ul>"
    for (const task of taskObj) {
        taskHTML += `<li><a href="/admin/tasks/${task.id}">${task.title}</a></li>`
    }
    taskHTML +="</ul>"

    return taskHTML
}

function projectContainerForId(projectId) {
    return document.querySelector(`#project-overview-container-${projectId}`)
}

function clearContainer(projectId) {
    projectContainerForId(projectId).innerHTML = ""
}
$(function() {
    // document ready
    listenForClick()
});

function listenForClick() {
    $(".js-overview").on('click', function(event){
        event.preventDefault();
        const projectId = $(this).data("id")
        getProject(projectId)
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
        console.log("this is the data returned: ", data)
        let theProject = new Project(data)
        console.log("this is the created project JS object: ", theProject)
        let projectHTML = theProject.postHTML()
        console.log("this is the HTML to append: ", projectHTML)
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
        <div>
            <p>Deadline: ${this.deadline}</p>
            <p># of Tasks: ${this.tasks.length}</p>
            <p># of people: ${this.users.length}</p>
        </div>
    `)
}
$(function(){
    button = $("#show-user-projects-btn")
    listenForButtonPress(button);
})

function listenForButtonPress(el) {

    el.on('click', function(event){
        const userId = parseInt(this.getAttribute("user-id"))
        
        event.preventDefault();
        if ($('#user-project-index').text()!=="") {
            $('#user-project-index').html("")             
            $('#show-user-projects-btn').text("Show Projects")
        } else {
            getUserProjects(userId)
            $('#show-user-projects-btn').text("Hide Projects")
        }
    })
}
class User {
    constructor(obj) {
        this.id = obj.id
        this.username = obj.username
        this.email = obj.email
        this.image = obj.image
        this.admin = obj.admin
        this.tasks = obj.tasks
        this.projects = obj.projects
    }
}

function getUserProjects(userId) {
    const baseUrl = 'http://localhost:3000/admin/users/' + userId
    // make a request to the server - api -> project list
    $.get(
        baseUrl,
        function(data) {
            jsUser = new User(data)
            if(jsUser.projects.length === 0) {
                $('#user-project-index').html("<p>There are no projects to show</p>")
            } else {
                let userProjectsHTML = jsUser.getHTML()
                $('#user-project-index').html(userProjectsHTML)
            }
        }, 'json'
    )
    .fail(function(error) {
        alert("Error getting Server Data!")
    });
}

User.prototype.getHTML = function () {
    let projectListHTML = "<h3>Project List</h3><br>"
    for (const project of this.projects) {
        projectListHTML += 
            `
            <h5>${project.name}</h5>
            <p>Deadline: ${project.deadline}</p>
            <p><a href="#" data-id="${this.id}">Show Tasks</a></p><br>
            `
    }
    return projectListHTML
}
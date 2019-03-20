$(function(){
    el = $("#show-user-projects")
    listenForButtonPress(el);
})

function listenForButtonPress(el) {

    el.on('click', function(event){
        const userId = parseInt(this.getAttribute("user-id"))
        
        event.preventDefault();                
        getUserProjects(userId)
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
            let userProjectsHTML = jsUser.getHTML()
            $('#project-list-table').html(userProjectsHTML)
        }, 'json'
    )
    .fail(function(error) {
        alert("Error getting Server Data!")
    });
}

User.prototype.getHTML = function () {
    let tableRows = ""

    for (const project of this.projects) {
        tableRows += `
                    <tr>
                        <td>${project.name}</td>
                        <td>${project.deadline}</td>
                        <td><a href="/admin/users/${this.id}/projects/${project.id}">Open Project</a></td>
                    </tr>
                    `
    }
    return tableRows
}
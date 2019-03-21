$(function() {
    // document ready
    listenForMoreClick()
});

function listenForMoreClick() {
    $(".js-more").each(function(num, el) {
        $(el).on('click', function(event){
            event.preventDefault();
            const projectId = parseInt($(el).attr("data-id"));
            const projectDiv = $(`.project-data[data-id=${projectId}]`)
            if (projectDiv.text() === "") {
                getProject(projectId)
                $(el).text("Show Less")
            } else {
                $(projectDiv).text("")
                $(el).text("Show More")
            }
        })
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

            $(`.project-data[data-id=${projectId}]`).html(projectHTML)
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
            ${listHTML(this.tasks)}
            <p><strong>Team:</strong>:</p>
            ${listHTML(this.users)}
        </div>
    `)
}

function listHTML(objCollection) {
    let listHTML = "<ul>"
    for (const obj of objCollection) {
        if (obj.constructor.name === "Task") {
        listHTML += `<li><a href="/admin/tasks/${obj.id}">${obj.title}</a></li>`
        } else if (obj.constructor.name === "User") {
            listHTML += `<li><a href="/admin/users/${obj.id}">${obj.username}</a></li>`
        }
    }
    listHTML +="</ul>"

    return listHTML
}
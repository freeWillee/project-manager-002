module ProjectsHelper
  def due_date(project)
    project.deadline.strftime("%b %d, %Y")
  end
end

module ProjectsHelper
  def due_date(project)
    project.deadline.strftime("%b %d, %Y")
  end

  def nice_date_format(project)
    project.deadline.to_date
  end
end

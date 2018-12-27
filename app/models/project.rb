class Project < ApplicationRecord
  has_many :tasks
  has_many :users, through: :tasks

  def days_remaining
    today = DateTime.now
    due_date = self.deadline.to_date
    (due_date - today).to_i
  end

  def weeks_remaining
    self.days_remaining / 7
  end

  def all_project_tasks
    Task.where("project_id = ?", self.id)
  end

end

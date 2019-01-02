class Project < ApplicationRecord
  has_many :tasks
  has_many :users, through: :tasks
  
  #validations
  validates :name, presence: true
  validate :deadline_not_in_the_past
  
  def deadline_not_in_the_past
    errors.add(:deadline, "can't be in the past") if !:deadline.blank? || deadline < Date.today
  end

  def days_remaining
    today = Date.today
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

class Project < ApplicationRecord
  has_many :tasks
  has_many :users, through: :tasks
  
  #validations
  validates :name, presence: true
  validates :deadline, presence: true
  validate :deadline_not_in_the_past
  
  def deadline_not_in_the_past
    if !deadline.blank?
      errors.add(:deadline, "can't be in the past") if deadline < Date.today
    end
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

  def self.by_user(user_id)
    
  end

  def next
    project = Project.where("id > ?", id).first

    if project
      project
    else
      Project.first
    end
  end

  def previous
    project = Project.where("id < ?", id).last

    if project
      project
    else
      Project.last
    end
  end
end

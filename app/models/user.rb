class User < ApplicationRecord
  has_many :tasks
  has_many :projects, through: :tasks
  has_secure_password
  accepts_nested_attributes_for :projects

  def is_admin?
    self.admin == 1
  end

  def all_user_tasks
    Task.where("user_id = ?", self.id)
  end

  def projects_attributes=(project_attributes)
    project_attributes.values.each do |project_attribute|
      project = Project.find_or_create_by(project_attribute)
      self.projects << project
    end
  end
end

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :title, presence: true

  def self.by_user(user_id, project_id)
    where(user: user_id, project: project_id)
  end

  def self.almost_done
    where("percent_complete > ?", 50)
  end
end

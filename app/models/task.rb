class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :title, presence: true

  def unfinished_tasks
    Task.where("percent_complete < 100")
  end
end

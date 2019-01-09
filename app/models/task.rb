class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def unfinished_tasks
    Task.where("percent_complete < 100")
  end
end

class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :percent_complete, :user_id, :project_id
  belongs_to :user
  belongs_to :project
end

class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :deadline
  has_many :tasks
  has_many :users
end
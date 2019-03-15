class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :image, :admin
  has_many :tasks
  has_many :projects
end

class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :admin
  has_many :tasks
  has_many :projects, through: :tasks
end

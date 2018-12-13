class User < ApplicationRecord
  has_many :roles_users
  has_many :roles, through: :roles_users
  has_many :tasks
  has_many :projects, through: :tasks
  has_secure_password
end
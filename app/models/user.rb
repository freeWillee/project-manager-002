class User < ApplicationRecord
  has_many :roles
  has_many :positions, through: :roles
  has_many :tasks
  has_many :projects, through: :tasks
  has_secure_password
end

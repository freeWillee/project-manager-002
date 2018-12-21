class User < ApplicationRecord
  has_many :tasks
  has_many :projects, through: :tasks
  has_secure_password

  def is_admin?
    self.admin == 1
  end
end

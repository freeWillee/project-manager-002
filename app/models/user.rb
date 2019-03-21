class User < ApplicationRecord
  #associations
  has_many :tasks
  has_many :projects, through: :tasks
  
  #bcrypt
  has_secure_password

  # validations
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true

  accepts_nested_attributes_for :projects

  def is_admin?
    self.admin == 1
  end

  def all_user_tasks
    Task.where("user_id = ?", self.id)
  end
end

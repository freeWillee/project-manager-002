class CreateTasksJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, default: "Create New Task Here..."
      t.string :content
      t.integer :percent_complete, default: 0
      t.integer :user_id
      t.integer :project_id
    end
  end
end

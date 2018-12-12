class CreateTasksJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.integer :percent_complete
      t.integer :user_id
      t.integer :project_id
    end
  end
end

class CreateTasksJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :projects, table_name: :tasks do |t|
      t.string :title
      t.string :content
      t.integer :percent_complete
    end
  end
end

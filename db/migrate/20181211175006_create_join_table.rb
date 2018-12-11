class CreateJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :positions, table_name: :roles
  end
end

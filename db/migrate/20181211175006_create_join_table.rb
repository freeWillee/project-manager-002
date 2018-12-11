class CreateJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.belongs_to :user
      t.belongs_to :position
      t.string :name
    end
  end
end

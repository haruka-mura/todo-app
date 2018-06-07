class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :user_id, null: false
      t.integer :team_id, null: false
      t.integer :state, null: false

      t.timestamps
    end
    add_index :tasks, :user_id
    add_index :tasks, :team_id
    add_foreign_key :tasks, :users
    add_foreign_key :tasks, :teams
  end
end

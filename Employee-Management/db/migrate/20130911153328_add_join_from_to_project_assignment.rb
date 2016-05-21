class AddJoinFromToProjectAssignment < ActiveRecord::Migration
  def change
    add_column :project_assignments, :join_from, :date
  end
end

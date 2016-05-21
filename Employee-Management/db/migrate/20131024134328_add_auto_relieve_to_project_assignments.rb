class AddAutoRelieveToProjectAssignments < ActiveRecord::Migration
  def change
    add_column :project_assignments, :auto_relieve, :boolean, default: true
  end
end

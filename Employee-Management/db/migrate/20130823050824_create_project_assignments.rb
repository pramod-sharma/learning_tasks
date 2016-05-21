class CreateProjectAssignments < ActiveRecord::Migration
  def change
    create_table :project_assignments do |t|
      t.integer :employee_id
      t.integer :project_id
      t.date :relieving_date
      t.integer :involvement

      t.timestamps
    end
  end
end

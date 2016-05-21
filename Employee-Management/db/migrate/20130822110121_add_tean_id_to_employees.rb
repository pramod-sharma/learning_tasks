class AddTeanIdToEmployees < ActiveRecord::Migration
  def change
  	add_column :employees, :team_id, :integer
    add_index  :employees, :team_id
  end
end

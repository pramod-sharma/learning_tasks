class AddTeamLeadIdToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :team_lead_id, :integer
    add_index :employees, :team_lead_id
  end
end

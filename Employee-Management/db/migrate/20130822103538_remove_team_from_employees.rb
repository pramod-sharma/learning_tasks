class RemoveTeamFromEmployees < ActiveRecord::Migration
  def change
  	change_table :employees do |emp|
  		emp.remove :team
  	end
  end
end

module EmployeesHelper
					 
	def team_lead employee
		employee.team_lead.try :name
	end

	def team_name employee
		employee.team.try :name
	end

	def current_project_asignments( employee_id )
    Employee.find( employee_id ).live_assignments
  end

  def previous_project_asignments( employee_id )
    Employee.find( employee_id ).previous_assignments
  end 

  def current_projects(assignments)
  	assignments.collect do |assignment|
  		assignment.project.name
  	end
  end
end

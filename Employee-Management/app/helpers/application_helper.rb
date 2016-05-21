module ApplicationHelper

  def employee_name(employee_id)
    Employee.find_by( :id => employee_id ).try :name
  end

  def project_name(project_id)
    Project.find_by( :id => project_id ).try :name
  end

  def team_options
    Team.not_deleted.order(:name).pluck( 'name', 'id' )
  end

  def employee_options(employee = nil)
    condition = employee.present? && employee.persisted? ? "id != #{employee.id}" : ""
    Employee.active_on(Date.current).where(condition).order(:name).pluck( 'name', 'id')
  end

  def project_options
    Project.active.order(:name).pluck( 'name', 'id')
  end

  def employee_collection(locals)
    key = locals.keys
    if locals.has_key? :team_id
      collection = Team.find(locals[:team_id]).employees.order(:name)
    else
      #To find employee listing sorted by team name, team_lead name and then by employee name
      query = "SELECT employee.* FROM employees AS employee LEFT JOIN employees AS team_lead
              ON employee.team_lead_id = team_lead.id join teams AS team on employee.team_id = team.id
              order by team.name, employee.team_lead_id IS NULL, team_lead.name, employee.name"

      collection = Employee.find_by_sql(query)        
      # collection = Employee.joins(" LEFT JOIN employees AS team_lead on
      #   employees.team_lead_id = team_lead.id join teams AS team on employees.team_id = team.id
      #   order by team.name, employees.team_lead_id IS NULL, team_lead.name, employees.name")
      
      if locals[:order] && ( locals[:order] == 'decreasing' )
        collection = collection.sort_by{ |employee| employee.involvement_as_on( locals[:involvement_date] ) }.reverse
      elsif locals[:order] && ( locals[:order] == 'increasing' )
        collection = collection.sort_by{ |employee| employee.involvement_as_on( locals[:involvement_date] ) }
      end
    end
    return key, collection
  end

  def project_collection(locals)
    projects, key = Hash.new, Array.new
    projects.merge!( :running_projects => Project.active )
    projects.merge!( :confirmed_projects => Project.confirmed )
    projects.merge!( :potential_projects => Project.potential )
    projects.merge!( :completed_projects => Project.inactive )
    return key, projects
  end

  def total_involvement( employee, hash )
    employee.project_assignments.sum do |project_assignment|
      ( involve_project?(project_assignment, hash) ) ? ( project_assignment.involvement || 0 ) : 0
    end
  end

  def involve_project?( project_assignment, hash )
    return ( project_assignment.join_from <= hash[:involvement_date]) && ( project_assignment.relieving_date >= hash[:involvement_date])
  end

  def generate_employee_options(project_id)
    Employee.active_on(Date.current).order(:name).pluck('name', 'id') - @project.employees.order(:name).pluck('name', 'employees.id')
  end

  def generate_project_options(employee_id)
    Project.where(" state != ?", Project::STATE['Completed']) .order(:name).pluck('name', 'id')# - @employee.projects.order(:name).pluck('name', 'projects.id')
  end

  def total_involvement_of_employee(employee, involvement_date)
    total_involvement = employee.current_assignments_on(involvement_date).sum( :involvement )
  end


  def employee_listing_page? key
    !( (key.include? :project_id) || (key.include? :team_id) )
  end

  def project_show_page? key
    key.include? :project_id
  end

  def team_show_page? key
    key.include? :team_id
  end

  def project_involvement(employee, hash)
    ProjectAssignment.find_by( :employee_id => employee.id, :project_id => hash[:project_id] ).try :involvement
  end

  def joining_date(employee_id, project_id)
    format_date ProjectAssignment.where( :employee_id => employee_id, :project_id => project_id )
      .future_project_assignments( Date.current ).last.try :join_from
  end

  def relieving_date( employee_id, project_id )
    format_date ProjectAssignment.where( :employee_id => employee_id, :project_id => project_id )
      .future_project_assignments( Date.current ).last.try(:relieving_date)
  end

  def logged_in?
    session.has_key?( 'user_id' )
  end

  def format_date date
    date ? date.to_s(:string_format) : nil
  end

  def current_user
    Employee.find_by( :id => session[:user_id] )
  end

  def header_name_for_employee( key )
    employee_listing_page?( key ) ? "Name" : "Employee Name"
  end

end

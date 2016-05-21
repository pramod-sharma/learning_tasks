module ReportHelper

  def report_start_date
    session[:report_start_date] || Date.current
  end

  def report_end_date
    session[:report_end_date] || ( report_start_date >> 1 )
  end

  def current_year
    Date.current.year
  end

  def new_order(order)
    if order.nil? || order == 'increasing'
      'decreasing'
    elsif order == 'decreasing'
      'increasing'
    end
  end

  def image_for_sort(order)
    if order.nil?
      image_tag('sort.gif', class: 'sorter')
    elsif order == 'increasing'
      image_tag('increasing-sort.gif')
    elsif order == 'decreasing'
      image_tag('decreasing-sort.gif')
    end
  end

  def sorted_employees(team, utilization_date, order)
    collection = team.employees.active_on(utilization_date)
    if order && (order == 'decreasing' )
      collection = collection.sort_by{ |employee| employee.involvement_as_on(utilization_date) }.reverse
    elsif order && (order == 'increasing')
      collection = collection.sort_by{ |employee| employee.involvement_as_on(utilization_date) }
    end
    collection
  end     

  def current_month
    MONTH[Date.current.month - 1]
  end

  def relieving_employee_list( from_date, till_date )
    # from_date, till_date = Date.parse( from_date ), Date.parse( till_date )
    employees_table, header_fields = [], []
    Employee.active_on(from_date).order(:name).each do |employee|
      employee_row = []
      relieving_assignments = employee.project_assignments.where("relieving_date <= ? AND relieving_date >= ? ", till_date, from_date )
      relieving_assignments.each do |project_assignment|  
        project = project_assignment.project
        involvement = employee.involvement_as_on(project_assignment.relieving_date + 1)
        if( involvement < 100)
          employee_row << generate_employee_row( employee, project, format_date( project_assignment.relieving_date ),
            involvement )
        end
      end
      if relieving_assignments.empty? && ( employee.involvement_as_on( from_date ) < 100 )
        employee_row << generate_employee_row( employee, '', '', employee.involvement_as_on( from_date ) ) 
      end
      employees_table += employee_row
    end
    return employees_table
  end

  def generate_employee_row(employee, project, relieving_date, involvement )
    { employee: link_to_employee(employee), project: link_to_project(project),
    relieving_date: relieving_date, availability: "#{ number_to_percentage( 100 - involvement, precision: 0)  }" }
  end

  def class_for( employee_involvement )
    if employee_involvement >= 100
      return "fully-involved"
    elsif employee_involvement <= 0
      return "fully-available"
    else
      return "average-involved"
    end
  end

  def project_details(project)
    "<p class='text-left'>Status: #{ Project::STATE.key(project.state) } </p> <p class='text-left'> #{ start_label(project) } : #{format_date( project.start_date )} </p> <p class='text-left'> #{ end_label(project) } : #{ format_date(project.end_date) } </p>"
  end

  def start_label(project)
    project.start_date <= Date.current ? "Start Date" : "Expected Starting Date"
  end

  def end_label(project)
    project.end_date <= Date.current ? "End date" : "Expected End Date"
  end

  def class_name field_name
    field_name.gsub(/(_%)$/, '')
  end

  def link_to_employee(employee)
    link_to( employee.name, employee_path(employee), class: 'report_link')
  end

  def link_to_project(project)
    project.present? ? link_to( project.name, project_path(project), class: 'report_link', title: " #{ project_details(project) }" ) : ''
  end

  def link_to_team_lead( team_lead )
    link_to( team_lead.name, employee_path( team_lead ), class: 'report_link' ) if team_lead
  end

  
  def generate_notifications
    notifications = []
    Project.where("state != #{Project::STATE['Completed']}").find_each do |project|
      if project.approaching_start_date? && ! project.running?
        message = "#{project.name} Project has #{(project.start_date - Date.current).to_i} days left to start. Please mark it as Running Poject or update project timelines."
        message_date = project.start_date
      elsif project.started? && project.state != Project::STATE['Running']
        message = "#{project.name} Project was supposed to start by #{project.start_date.to_s(:string_format)}. Please mark it as Running Project or update project timelines."
        message_date = project.start_date
      elsif project.ended?
        message = "#{project.name} Project was supposed to end on #{project.end_date.to_s(:string_format)}. Please mark it as Completed or update the project timelines."
        message_date = project.end_date
      elsif project.approaching_end_date? && project.state != Project::STATE['Completed']
        message = "#{project.name} Project has #{(project.end_date - Date.current).to_i} days left to end. Please mark it as Completed or update project timelines."
        message_date = project.end_date
      end
      notifications << { message_date: message_date, message: link_to(message, project) }  if message.present?
    end
    ProjectAssignment.where("relieving_date <=  '#{(Date.current + 15.days).to_s}' AND relieving_date > '#{(Date.current).to_s}'").find_each do |assignment|
      message = "#{assignment.employee.name.capitalize} is going to be relieved from #{assignment.project.name.capitalize} on #{assignment.relieving_date.to_s(:string_format)}"
      message_date = assignment.relieving_date
      notifications << { message_date: message_date, message: link_to(message, assignment.employee) } if message.present?      
    end
    ProjectAssignment.where("join_from <=  '#{(Date.current + 15.days).to_s}' AND join_from > '#{(Date.current).to_s}'").find_each do |assignment|
      message = "#{assignment.employee.name.capitalize} is going to join #{assignment.project.name.capitalize} on #{assignment.join_from.to_s(:string_format)}"
      message_date = assignment.join_from
      notifications << { message_date: message_date, message: link_to(message, assignment.employee) } if message.present?          
    end
    notifications
  end
end

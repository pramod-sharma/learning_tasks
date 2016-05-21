module ProjectsHelper
  current_year = Date.current.year
  Year = [ current_year - 2, current_year - 1,
    current_year, current_year + 1, current_year + 2,
    current_year + 3, current_year + 4, current_year + 5 ]

  def find_monthly_billings(project_id)
    Project.find(project_id).monthly_billings
  end

  def first_monthly_billing?
    MonthlyBilling.where( :project_id => params[:project_id] ).count == 1
  end

  def label_for_project_end_date
    @project.end_date < Date.current ? "End Date" : "Expected End Date"
  end

  def label_for_project_start_date
    @project.start_date < Date.current ? "Start Date" : "Expected Start Date"
  end

  def current_asignments(project_id)
    Project.find(project_id).live_assignments
  end

  def previous_asignments(project_id)
    Project.find(project_id).previous_assignments
  end 

end

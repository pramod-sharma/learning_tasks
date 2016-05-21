class Employee < ActiveRecord::Base

  #FIXME_AB: Designation should be a hash and we should save its value in database.
  # for example {"Project Manager" => 1, 'Software Developer' => 2}
  # and you should display "Project Manager" on the site and should save 1 in the database.
  # Designations I need is: trainee, Software engineer, Sr. Software Engineer, Team leader, project manager, frontend engineer, sr. frontend engineer, quality analyst
  # Also create a script so that old designations can be mapped with the new one.
  #Fixed
  DESIGNATIONS = { 'Trainee' => 1, 'Software engineer' => 2, 'Sr. Software Engineer' => 3,
    'Team leader' => 4, 'Project manager' => 5, 'Frontend engineer' => 6,
    'Sr. frontend engineer' => 7, 'Quality analyst' => 8 }

  after_save :create_or_update_revenue_projection, if: proc { potential_revenue_changed? || actual_revenue_changed? } 

  validates :email, :name, :designation, :potential_revenue, :actual_revenue, :team, presence: true
  validates :email, :uniqueness => { :case_sensitive => false }, :format => { :with => EMAIL_VALIDATOR_REGEX }, allow_blank: true
  validates :potential_revenue, :actual_revenue, numericality: { greater_than_or_equal_to: 0,
    only_integer: true }, allow_blank: true
  validates :designation, inclusion: { in: DESIGNATIONS.values }, allow_blank: true

  has_many :project_assignments
  has_many :projects, :through => :project_assignments
  has_many :subordinates, class_name: 'Employee', foreign_key: 'team_lead_id'
  has_many :revenue_projections
  belongs_to :team_lead, class_name: 'Employee'
  belongs_to :team

  scope :active, lambda { not_deleted.where( active: true ) }
  scope :inactive, lambda { not_deleted.where( active: false ) }
  scope :active_on, lambda { |relieving_date| not_deleted.where("relieving_date >= ? OR relieving_date IS NULL", relieving_date) }

  #FIXME_AB: Should be using user's id
  #FIXME_NISH Please create a current_user method in controller rather than user session[:id]
  # Fixed

  # FIXME_KD: Don't leave space after and before variable if using parenthesis, liks ( date ), use: (date)
  # Fixed

  def active_on?(date)
    relieving_date.nil? || relieving_date >= date
  end

    # FIXME_KD: Use named options while creating sql.
    # OR you can use joined_on_or_before(date) and relieving_on_or_after(date)
    # Fixed

  def relieve(replacement_team_lead_id, new_relieving_date)
    if subordinates.any? && replacement_team_lead_id.blank?
      errors.add(:base, "You must provide new team leader for the subordinates.")
    elsif new_relieving_date.blank?
      errors.add(:base, "You must provide the relieving date for employee.")
    else
      new_relieving_date = Date.parse(new_relieving_date)
      Employee.transaction do    
        current_assignments_on(new_relieving_date).each do |assignment|
          assignment.update_attributes(relieving_date: new_relieving_date)
        end

        subordinates.each do |subordinate|
          if subordinate.id != replacement_team_lead_id
            subordinate.update_attributes(team_lead_id: replacement_team_lead_id)
          else
            subordinate.update_attributes(team_lead_id: nil)
          end
        end
        update_attributes(relieving_date: new_relieving_date, active: false)
      end
    end
    self
  end

  def current_assignments_on( date )
    project_assignments.where( "join_from <= :date AND relieving_date >= :date", date: date)
  end

  def revenue_projection_of( date )
    revenue_projections.where( "date <= ?", date ).order('date DESC').first
  end

  def current_user?( current_user )
    id == current_user.id
  end

  def revenue_projection_of(date)
    # FIXME_KD: Use named options while creating sql.
    # Fixed
    revenue_projections.where("date <= :report_date", report_date: date).order('date DESC').first
  end

  def live_assignments
    project_assignments.future_project_assignments(Date.current)
  end

  def previous_assignments
    project_assignments.previous_or_manually_relieved_project_assignments(Date.current)
  end
  # FIXME_KD: Should be in helpers, not a part of buisness logic.
  # Fixed
  # FIXME_KD: method name is not appropriate, may be create_or_update_revenue_projection is better or something else
  # Fixed
  # FIXME_KD: Never use Date.today, always use Date.current.
  # Fixed
  
  def create_or_update_revenue_projection
    revenue_projection = revenue_projections.where(date: Date.current.beginning_of_month, employee_id: id).first_or_initialize
    revenue_projection.actual_revenue = actual_revenue
    revenue_projection.potential_revenue = potential_revenue
    revenue_projection.save
  end

  def involvement_as_on(date = Date.current)
    Employee.joins(project_assignments: :project).where("employees.id = #{id} AND 
      join_from <= '#{date}' AND project_assignments.relieving_date >= '#{date}' 
      AND projects.state != #{Project::STATE['Potential']}").sum(:involvement)
    # query = "SELECT sum(involvement) as involvement from employees JOIN project_assignments JOIN projects on
    #   project_assignments.employee_id = employees.id AND project_assignments.project_id = projects.id
    #   WHERE employees.id = #{id} AND join_from <= '#{date}' AND project_assignments.relieving_date >= '#{date}' AND projects.state != #{Project::STATE['Potential']}"
    # ActiveRecord::Base.connection().execute(query).first[0] || 0
  end
end

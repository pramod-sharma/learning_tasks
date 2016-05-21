class Project < ActiveRecord::Base
  STATE = { 'Potential' => 1, 'Confirmed' => 2, 'Completed' => 3, 'Running' => 4 }
  
  validates :name, :start_date, :end_date, :state, presence: true
  validates :name, :uniqueness => { :case_sensitive => false }, allow_blank: true 
  # FIXME_KD: store error messages in yml files and use from there.
  # Fixed
  validates :end_date, :date => {:after_or_equal_to => :start_date}, allow_blank: true
  validates :state, inclusion: { in: STATE.values }, allow_blank: true

  has_many :project_assignments, dependent: :destroy
  has_many :employees, :through => :project_assignments
  has_many :monthly_billings, dependent: :destroy, order: 'billing_date DESC'
  # before_destroy :project_deactivated?
  # FIXME_KD: use state_changed? instead of state_change
  # Fixed
  before_save :set_project_end_date,  if: proc { state_changed? && state_change.include?( STATE['Completed'] ) }
  before_destroy :potential?, prepend: :true

  scope :active, lambda { not_deleted.where( state: STATE['Running'] ) }
  scope :inactive, lambda { not_deleted.where( state: STATE['Completed'] ) }
  scope :potential, lambda { not_deleted.where( state: STATE['Potential'] ) }
  scope :confirmed, lambda { not_deleted.where( state: STATE['Confirmed'] ) }
  scope :active_on, lambda { |report_date| not_deleted.where("start_date <= :report_date AND end_date >= :report_date", report_date: report_date )}

  STATE.each do |key, value|
    define_method("#{ key.downcase }?"){ state == value }
  end
  # FIXME_KD: what is the need of update_columns?, You can use self.end_date = nil/Date.current, 
  # whatever is the logic, as this will execute in before_save callback
  # FIXME_KD: Never use update_columns method as it will bypass all callbacks and will not update created_at and update_at
  # Fixed
  def set_project_end_date
    if state_was == STATE['Completed']
      end_date = nil
      active = true
    else
      active = false
      end_date = Date.current
    end
  end

  def current_assignments_on(date)
    # FIXME_KD: You can use joined_on_or_before and relieving_on_or_after
    # Comment:- We are using these two always in combination hence replaced the logic
    project_assignments.where("join_from <= :date AND relieving_date >= :date", date: date)
  end

  # FIXME_KD: This is controllers code. Write in the controller
  # Comment:- Removed from code as it is of no use in functionality

  # FIXME_KD: This is controllers code. Write in the controller
  # Comment:- Removed from code as it is of no use in functionality

    #FIXME_NISH Please move extra code in this method as callback.
    # Because it should also run when user destroy instead of deactivate.

    #FIXME_NISH same as deactivate method.

  def live_assignments
    project_assignments.future_project_assignments(Date.current)
  end

  def previous_assignments
    project_assignments.previous_or_manually_relieved_project_assignments(Date.current)
  end

  def potential?
    state == STATE['Potential']
  end

  def approaching_start_date?
    days_left = start_date - Date.current
    days_left <= 15 && days_left > 0
  end

  def approaching_end_date?
    days_left = end_date - Date.current
    days_left <= 15 && days_left >= 0
  end

  def started?
    Date.current >= start_date
  end

  def ended?
    Date.current > end_date
  end
end


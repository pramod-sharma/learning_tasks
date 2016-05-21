class ProjectAssignment < ActiveRecord::Base
  belongs_to :employee
  belongs_to :project

  validates :project_id, :employee_id, :join_from, :relieving_date, presence: true
  validates :relieving_date, :date => { :after_or_equal_to => :join_from },
    allow_blank: true
  validates :involvement, numericality: { greater_than_or_equal_to: 0, only_integer: true },
    allow_blank: true
  # FIXME_KD: this should be validation instead of callback.
  # Fixed
  validate :no_previous_assignments?, on: :create

  # FIXME_KD: scope name is not in accordance what is wriiten inside the block.
  # Comment:- Removed scope because of no use
  # FIXME_KD: scope name is not in accordance what is wriiten inside the block. 
  scope :previous_or_manually_relieved_project_assignments, lambda { |date| where("(relieving_date < :date ) OR ( relieving_date = :date AND auto_relieve = false)", date: date ) }

  scope :future_project_assignments, lambda { |date| where("relieving_date >= :date", date: date) }

  scope :future_project_assignments, lambda{ |date| where("relieving_date >= ? AND auto_relieve = ?", date, true ) }

  def relieve_employee( new_joining_date, involvement, relieving_date = 1.day.ago )
    if join_from <= Date.today
      update_attributes( join_from: new_joining_date, relieving_date: relieving_date, auto_relieve: false, involvement: involvement )
    else
      destroy
    end
    self
  end

  def update_assignment(new_joining_date, new_relieving_date, new_involvement)
    if new_relieving_date <= join_from # IN case new relieving date is less than join from date
      errors.add(:base, "Relieving Date can't be lesss than Joining Date")
    elsif new_involvement < 0 
      errors.add(:base, "Involvement can't be less than 0")
    elsif (new_involvement == involvement) || (new_joining_date >= Date.current) || (new_relieving_date <= Date.current)
      update_attributes(join_from: new_joining_date, relieving_date: new_relieving_date, involvement: new_involvement)
    else
      relieve_employee( new_joining_date, involvement )
      ProjectAssignment.create(project_id: project_id, employee_id: employee_id, join_from: Date.current,
        relieving_date: new_relieving_date, involvement: new_involvement)
    end
    self
  end

  def no_previous_assignments?
    current_assignmments = ProjectAssignment.where(project_id: project_id, employee_id: employee_id)
      .where("(join_from <= :joining_date AND relieving_date <= :relieving_date AND relieving_date >= :joining_date )
        OR ( join_from >= :joining_date AND relieving_date <= :relieving_date )
        OR ( join_from >= :joining_date AND relieving_date >= :relieving_date AND join_from <= :relieving_date  )
        OR ( join_from <= :joining_date AND relieving_date >= :relieving_date) ",
        joining_date: join_from, relieving_date: relieving_date)

    if current_assignmments.any?
      errors.add( :base, "#{ current_assignmments.first.employee.name } is already assigned to #{ current_assignmments.first.project.name } for given interval" )
    end
  end
end
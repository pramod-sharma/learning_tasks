class MonthlyBilling < ActiveRecord::Base
  belongs_to :project

  #FIXME_NISH club month, amount and year validation.
  # Fixed
  validates :billing_date, :amount, :project_id, presence: true
  validates :billing_date, uniqueness: { scope: :project_id }, allow_blank: true
  validates :amount, numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_blank: true

  scope :uncompleted_projects_billing, lambda {
    joins(:project)
    .where(" projects.state != #{ Project::STATE['Completed'] }")
  }

  scope :non_potential_projects, lambda { |billing_date|
    joins(:project)
    .where(" projects.state != #{ Project::STATE[ 'Potential' ] } AND billing_date = :billing_date", billing_date: billing_date)
  }

  scope :of, lambda { |billing_date| where(billing_date: billing_date) }
  # FIXME_KD: no need of MonthlyBilling
  # Fixed
  # FIXME_KD: create scope instead of class method
  # FIXME_KD: no need of creating custom join query
  # Fixed

  # FIXME_KD: create scope instead of class method
  # FIXME_KD: can be written as: where(:billing_date => billing_date)
  # Fixed

  #FIXME_NISH i think we don't require this method as it is only calling other method.
    # Also, if we need a method with two names use alias or alias_method.
    #We can also pass Date.today.month as default parameters.

end

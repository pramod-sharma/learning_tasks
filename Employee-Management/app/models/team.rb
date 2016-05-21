class Team < ActiveRecord::Base
  validates :name, presence: true
  validates :name, :uniqueness => {:case_sensitive => false}, allow_blank: true

  has_many :employees, dependent: :restrict_with_error

  def team_leads
  	employees.where(team_lead_id: nil)
  end
  # # before_destroy :have_no_team_members?

  # #FIXME_NISH Please make this method as private.
  # def have_no_team_members?
  #   employees.empty?
  # end
end

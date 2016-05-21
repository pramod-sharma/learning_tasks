FactoryGirl.define do

  # sequence :name do ||
  #   "Test Team #{{}}"
  factory :team do
    name 'Test Team'
  end

  factory(:monthly_billing) do
    project
    billing_date Date.current.beginning_of_month
    amount 2000
  end
  
  factory :project do
    name 'Test Project'
    start_date { Date.today }
    end_date { Date.today >> 1 }
    state Project::STATE['Confirmed']
  end

  factory :project_assignment do
    employee
    project
    join_from 3.days.ago
    relieving_date 5.days.from_now
    involvement 20
  end
end
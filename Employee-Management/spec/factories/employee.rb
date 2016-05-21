FactoryGirl.define do

  factory :employee do
    team
    sequence(:name) { |n| "Test Employee #{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    designation Employee::DESIGNATIONS.values.first
    potential_revenue 2000
    actual_revenue 2500
    is_admin false

    trait :admin do
      is_admin true
    end
  end
end
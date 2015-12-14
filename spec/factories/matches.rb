FactoryGirl.define do
  factory :match do
    association :team_one, factory: :team
    association :team_two, factory: :team
  end
end

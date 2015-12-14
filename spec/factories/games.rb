FactoryGirl.define do
  factory :game do
    association :team_one, factory: :team
    association :team_two, factory: :team
    team_one_score 10
    team_two_score 7
  end
end

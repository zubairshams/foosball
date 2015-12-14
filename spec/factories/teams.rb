FactoryGirl.define do
  factory :team do
    name 'Real Madrid'
    users {[create(:user)]}
  end
end

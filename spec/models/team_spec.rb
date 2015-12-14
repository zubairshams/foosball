require 'rails_helper'

RSpec.describe Team, type: :model do
  it { should have_and_belong_to_many(:users) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:users) }
end

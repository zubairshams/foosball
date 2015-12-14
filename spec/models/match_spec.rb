require 'rails_helper'

RSpec.describe Match, type: :model do
  it { should have_many(:games) }
  it { should belong_to(:team_one) }
  it { should belong_to(:team_two) }
  it { should belong_to(:winning_team) }
  it { should validate_presence_of(:team_one) }
  it { should validate_presence_of(:team_two) }

  describe '#teams_must_be_uniq' do
    it 'should add an error if both teams are same.' do
      match = build(:match)
      match.team_two = match.team_one
      match.send :teams_must_be_uniq
      expect(match.errors[:base].first).to eq 'Both teams cannot be same.'
    end

    it 'should not return any error' do
      match = build(:match)
      match.send :teams_must_be_uniq
      expect(match.errors).to be_empty
    end
  end
end

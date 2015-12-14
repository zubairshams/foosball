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

  describe '#set_winner' do
    let(:team_one) { create(:team) }
    let(:team_two) { create(:team) }
    let(:game_one) { create(:game, team_one: team_one, team_two: team_two) }
    let(:game_two) { create(:game, team_one: team_one, team_two: team_two) }

    it 'should have a winner team' do
      match = create(:match, team_one: team_one, team_two: team_two, games: [game_one, game_two])
      match.set_winner
      expect(match.winning_team).to eq team_one
    end
    
    it 'should not set any winner team' do
      match = create(:match, team_one: team_one, team_two: team_two, games: [game_one])
      match.set_winner
      expect(match.winning_team).to be_nil
    end
  end
end

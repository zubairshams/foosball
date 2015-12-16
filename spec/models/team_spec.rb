require 'rails_helper'

RSpec.describe Team, type: :model do
  it { should have_and_belong_to_many(:users) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:users) }

  describe '.stats' do
    let(:team_one) { create(:team) }
    let(:team_two) { create(:team) }
    let(:game_one) { create(:game, team_one: team_one, team_two: team_two, team_one_score: 10, team_two_score: 7) }
    let(:game_two) { create(:game, team_one: team_one, team_two: team_two, team_one_score: 10, team_two_score: 5) }

    it 'should return teams stats correctly' do
      create(:match, team_one: team_one, team_two: team_two, games: [game_one, game_two])
      stats = Team.stats
      expect(stats.count).to eq 2
      expect(stats.map(&:name)).to eq [team_one.name, team_two.name]
      expect(stats.map(&:total_matches)).to eq [1, 1]
      expect(stats.map(&:total_wins)).to eq [1, 0]
    end
  end
end

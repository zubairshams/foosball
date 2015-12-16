require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_and_belong_to_many(:teams) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  describe '.stats' do
    let(:team_one) { create(:team) }
    let(:team_two) { create(:team) }
    let(:game_one) { create(:game, team_one: team_one, team_two: team_two, team_one_score: 10, team_two_score: 7) }
    let(:game_two) { create(:game, team_one: team_one, team_two: team_two, team_one_score: 10, team_two_score: 5) }

    it 'should return users stats correctly' do
      create(:match, team_one: team_one, team_two: team_two, games: [game_one, game_two])
      stats = User.stats
      expect(stats.count).to eq 2
      expect(stats.map(&:id)).to eq [team_one.users.first.id, team_two.users.first.id]
      expect(stats.map(&:total_games)).to eq [2, 2]
      expect(stats.map(&:total_wins)).to eq [2, 0]
    end
  end
end

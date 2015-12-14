require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should belong_to(:match) }
  it { should belong_to(:team_one) }
  it { should belong_to(:team_two) }
  it { should belong_to(:winning_team) }
  it { should validate_presence_of(:team_one) }
  it { should validate_presence_of(:team_two) }
  it { should validate_presence_of(:team_one_score) }
  it { should validate_presence_of(:team_two_score) }

  describe '#scores' do
    it 'should add an error if any of the team score is not 10.' do
      game = build(:game, team_one_score: 5, team_two_score: 3)
      game.send :scores
      expect(game.errors[:base].first).to eq 'One team must have a score of 10.'
    end

    it 'should add an error if both teams have score of 10.' do
      game = build(:game, team_one_score: 10, team_two_score: 10)
      game.send :scores
      expect(game.errors[:base].first).to eq 'Both teams cannot have a score of 10.'
    end

    it 'should not return any error' do
      game = build(:game)
      game.send :scores
      expect(game.errors).to be_empty
    end
  end

  describe '#set_winner' do
    it 'should have a winner team' do
      match = build(:match)
      game = build(:game, match: match)
      game.save
      expect(game.winning_team).to eq game.team_one
    end

    it 'should not set any winner team' do
      game = build(:game, team_one_score: 5, team_two_score: 3)
      game.save
      expect(game.winning_team).to be_nil
    end
  end
end

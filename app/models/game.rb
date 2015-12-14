class Game < ActiveRecord::Base
  belongs_to :match
  belongs_to :team_one, class_name: Team, foreign_key: 'team_one_id'
  belongs_to :team_two, class_name: Team, foreign_key: 'team_two_id'
  belongs_to :winning_team, class_name: Team, foreign_key: 'winning_team_id'

  validates :team_one, :team_two, :team_one_score, :team_two_score, presence: true
  validate :scores

  private
  
  def scores
    unless team_one_score == 10 || team_two_score == 10
      errors.add(:base, 'One team must have a score of 10.')
    end

    if team_one_score == 10 && team_two_score == 10
      errors.add(:base, 'Both teams cannot have a score of 10.')
    end
  end
end

class Match < ActiveRecord::Base
  has_many :games, dependent: :destroy
  belongs_to :team_one, class_name: Team, foreign_key: 'team_one_id'
  belongs_to :team_two, class_name: Team, foreign_key: 'team_two_id'
  belongs_to :winning_team, class_name: Team, foreign_key: 'winning_team_id'

  validates :team_one, :team_two, presence: true
  validate :teams_must_be_uniq
  validates :games, length: { minimum: 1, maximum: 3, message: 'Games must be at least 1 and at most 3.'}

  private
  
  def teams_must_be_uniq
    errors.add(:base, 'Both teams cannot be same.') if team_one_id == team_two_id
  end
end

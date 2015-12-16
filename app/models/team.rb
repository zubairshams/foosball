class Team < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, presence: true
  validates :users, length: { minimum: 1, maximum: 2, message: 'must be one or two in a team.' }

  def self.stats
    query = <<-SQL
      SELECT t1.name,
             coalesce(t2.total_wins, 0) AS total_wins,
             count(t1.id) AS total_matches,
             coalesce(round((t2.total_wins * 100)::numeric / count(t1.id), 2), 0) AS win_percentage
      FROM teams t1
        INNER JOIN matches ON matches.team_one_id = t1.id OR matches.team_two_id = t1.id
        INNER JOIN (
          SELECT teams.id, count(matches.winning_team_id) AS total_wins
          FROM teams
            LEFT JOIN matches ON teams.id = matches.winning_team_id
          GROUP BY teams.id) t2 ON t1.id = t2.id
      GROUP BY t1.id, t2.total_wins
      ORDER BY win_percentage DESC
    SQL

    self.find_by_sql(query)
  end
end

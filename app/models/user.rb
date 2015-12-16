class User < ActiveRecord::Base
  has_and_belongs_to_many :teams
  
  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.stats
    query = <<-SQL
      SELECT u1.id,
             concat(u1.first_name, ' ', u1.last_name) AS name,
             coalesce(u2.total_wins, 0) AS total_wins,
             count(u1.id) AS total_games,
             coalesce(round((u2.total_wins * 100)::numeric / count(u1.id), 2), 0) AS win_percentage
      FROM users u1
        INNER JOIN teams_users ON teams_users.user_id = u1.id
        INNER JOIN games ON games.team_one_id = teams_users.team_id OR games.team_two_id = teams_users.team_id
        LEFT OUTER JOIN (
          SELECT users.id, count(users.id) AS total_wins
          FROM users
            INNER JOIN teams_users ON teams_users.user_id = users.id
            INNER JOIN games ON games.winning_team_id = teams_users.team_id
          GROUP BY users.id) u2 ON u2.id = u1.id
      GROUP BY u1.id, u2.total_wins
      ORDER BY win_percentage DESC;
    SQL

    self.find_by_sql(query)
  end
end

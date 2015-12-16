class HomeController < ApplicationController
  def index
    @user_stats = User.stats
    @team_stats = Team.stats
  end
end

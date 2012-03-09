class Sprint
  def self.find_by_team(team_name)
    ScrumBoard::Client.find_sprints_by_team(team_name)
  end
end
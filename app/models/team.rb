class Team
  def self.find_by_name(name)
    ScrumBoard::Client.find_team_by_name(name)
  end
end
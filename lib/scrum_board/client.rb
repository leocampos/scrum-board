module ScrumBoard
  class Client
    def self.find_team_by_name(name)
      client.find_team_by_name(name)
    end
    
    def self.find_sprints_by_team(team_name)
      find_team_by_name(team_name).iterations
    end
    
    private
    def self.client
      @rally_client ||= RallyClient.new
      @rally_client
    end
  end
end
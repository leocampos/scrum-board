module ScrumBoard
  class RallyClient
    def initialize
      @connector = RallyConnector.new(:username => rally_configuration[:username], :password => rally_configuration[:password])
      @conn = @connector.connect
      @workspace = @connector.workspace
    end
    
    def find_team_by_name(name)
      #connector.workspace.projects[7].iterations.find {|sprint| sprint.name == 'Sprint #53'}.end_date
      #connector.workspace.projects[7].iterations.find {|sprint| sprint.name == 'Sprint #54'}.state
      @workspace.projects.find do |project|
        project.name.downcase == name
      end
    end
    
    private
    def rally_configuration
      @rally_configuration ||= ScrumBoard::Yml.read_from_config("rally_account")
      @rally_configuration
    end
  end
end
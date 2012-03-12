module ScrumBoard
  class RallyConnector
    attr_accessor :username, :password, :custom_headers
    attr_reader :conn, :workspace, :schedule_states, :defect_states, :api_version
  
    def initialize(options = {})
      @username = options[:username]
      @password = options[:password]
      @api_version = '1.29'
  
      if options[:custom_headers]
        @custom_headers = options[:custom_headers]
      else
        @custom_headers = CustomHttpHeader.new
        @custom_headers.name = 'CodebaseHQ to Rally Connector'
        @custom_headers.version = 'v0.0.0'
        @custom_headers.vendor = 'Abril Group'
      end
  
      @schedule_states = nil
      @defect_states = nil
      @workspace = nil
      @conn = nil
    end
    
    def find_workspace(workspace_name = nil)
      return nil unless (workspace_name and @conn)

      begin
        workspace = @conn.user.subscription.workspaces.find { |w| w.name == workspace_name && w.state == 'Open' }

        raise "Couldn't find workspace #{workspace_name}" if workspace.nil?

        return workspace
      rescue => e
        Rails.logger.error("\n#{e.to_s}")
        return nil
      end
    end
  
    def connect
      begin
        @conn = RallyRestAPI.new(:username => @username, :password => @password, :version => @api_version, :http_headers => @custom_headers)
        @workspace = find_workspace('Projetos Abril Midia')
      
        return @conn
      rescue => e 
        puts "Could not connect to Rally: #{e.to_s}"
        return nil
      end
    end
  end
end
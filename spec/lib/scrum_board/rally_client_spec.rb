require_relative '../../spec_helper'

describe ScrumBoard::RallyClient do
  use_vcr_cassette "rally_client", :record => :new_episodes, :preserve_exact_body_bytes => true
  
  context 'an instance' do
    before :each do
      @client = ScrumBoard::RallyClient.new
    end
    
    context 'should respond to' do
      it 'connect' do
        @client.should respond_to(:connect)
      end
      
      it 'find_team_by_name' do
        @client.should respond_to(:find_team_by_name)
      end
    end
    
    context 'on receiving call to connect' do
      it 'should assign a connector, a connection and a workspace' do
        @client.connect
        
        connector = @client.instance_variable_get('@connector')
        conn = @client.instance_variable_get('@conn')
        workspace = @client.instance_variable_get('@workspace')
        
        connector.should be
        conn.should be
        workspace.should be
        
        conn.username.should == 'codebasehq@abril.com.br'
        workspace.class.should == RestObject
        connector.class.should == ScrumBoard::RallyConnector
      end
    end
  end
end
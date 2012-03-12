require_relative '../../spec_helper'

describe ScrumBoard::Client do
  context 'class' do
    it 'should respond to find_team_by_name' do
      ScrumBoard::Client.should respond_to(:find_team_by_name)
    end
    
    it 'should respond to find_sprints_by_team' do
      ScrumBoard::Client.should respond_to(:find_sprints_by_team)
    end
    
    context 'on receiving a call to find_team_by_name' do
      before :each do
        ScrumBoard::Client.instance_variable_set('@rally_client', nil)
      end
      
      it 'should create a rally_client instance and call find_team_by_name' do
        ScrumBoard::Client.instance_variable_get('@rally_client').should be_nil
        
        stubbed = ScrumBoard::RallyClient.new
        ScrumBoard::RallyClient.expects(:new).once.returns(stubbed)
        stubbed.expects(:find_team_by_name).once
        
        ScrumBoard::Client.find_team_by_name("NOME")
      end
    end
    
    context 'on receiving a call to find_sprints_by_team' do
      before :each do
        ScrumBoard::Client.instance_variable_set('@rally_client', nil)
      end
      
      it 'should create a rally_client instance, call find_team_by_name and iteration on the returned value' do
        ScrumBoard::Client.instance_variable_get('@rally_client').should be_nil
        
        stubbed = ScrumBoard::RallyClient.new
        rest_object = {}
        rest_object.expects(:iterations).once
        
        ScrumBoard::RallyClient.expects(:new).once.returns(stubbed)
        stubbed.expects(:find_team_by_name).once.returns(rest_object)
        
        
        ScrumBoard::Client.find_sprints_by_team("NOME")
      end
    end
  end
end
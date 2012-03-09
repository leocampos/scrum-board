require_relative '../spec_helper'

describe Sprint do
  context 'class' do
    context 'should respond to' do
      it 'find_by_team' do
        Sprint.should respond_to(:find_by_team)
      end
    end
    
    context 'on receiving an method call to all' do
      it 'should deliver the request to ScrumBoardClient' do
        expected = [Sprint.new(:name=>'Sprint 1'), Sprint.new(:name=>'Sprint 2')]
        ScrumBoard::Client.expects(:find_sprints_by_team).with('Esparta').once.returns(expected)
        
        Sprint.find_by_team('Esparta').should == expected
      end
    end
  end
end
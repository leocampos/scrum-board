require_relative '../spec_helper'

describe Team do
  context 'class' do
    context 'should respond to' do
      it 'find_by_name' do
        Team.should respond_to(:find_by_name)
      end
    end
    
    context 'on find_by_name' do
      it 'should deliver the request to ScrumBoardClient' do
        expected = [Team.new(:name=>'Esparta')]
        ScrumBoard::Client.expects(:find_team_by_name).with('Esparta').once.returns(expected)
        
        Team.find_by_name('Esparta').should == expected
      end
    end
  end
end
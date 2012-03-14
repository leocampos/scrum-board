require_relative '../spec_helper'

describe Chamado do
  context 'instance' do
    before :each do
      @chamado = Chamado.new(:value => 'THIS IS THE TEXT', :project => Project.new)
    end
    
    context 'should respond to' do
      it 'create_page' do
        @chamado.should respond_to(:create_page)
      end
      
      it 'update_deploy_list' do
        @chamado.should respond_to(:update_deploy_list)
      end
    end
    
    context 'should delegate to ScrumBoard::ConfluenceClient' do
      it 'when create_page called' do
        client = ScrumBoard::ConfluenceClient.new
        client.expects(:create_page).once
        @chamado.create_page()
      end
      
      it 'when update_deploy_list called' do
        client = ScrumBoard::ConfluenceClient.new
        client.expects(:page_source).once
        client.expects(:update_page).once
        @chamado.update_deploy_list()
      end
    end
  end
end
require_relative '../../spec_helper'

describe ScrumBoard::ConfluenceClient do
  context 'instance' do
    before :each do
      @client = ScrumBoard::ConfluenceClient.new
    end
    
    context 'should respond to' do
      it 'page_source' do
        @client.should respond_to(:page_source)
      end
      
      it 'addPage' do
        @client.should respond_to(:add_page)
      end
    end
  end
end
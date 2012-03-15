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
      
      it 'add_page' do
        @client.should respond_to(:add_page)
      end
      
      it 'store_page' do
        @client.should respond_to(:store_page)
      end
    end
    
    context 'when receiving a call' do
      before :each do
        @client.instance_eval do
          def call_confluence(action, extras)
            {:action => action, :extras => extras}
          end
        end
      end
      
      context 'to page_source' do
        it 'should substitute titles + for spaces and call "call_confluence"' do
          @client.page_source('titulo+teste')[:extras][:title].should == 'titulo teste'
        end
      end
      
      context 'to add_page' do
        it 'should write tmp file with content' do
          content = "TESTE"
          temp_path = "teste de path"
          stub_file = Object.new
          Tempfile.expects(:new).with('confluence-page', Rails.root.join('tmp')).returns(stub_file)
          stub_file.expects(:write).with(content)
          stub_file.expects(:path).returns(temp_path)
          stub_file.expects(:close).once
          stub_file.expects(:unlink).once
          
          call_confluence_data = @client.add_page('addPage', content, :teste => 'ABC')
          call_confluence_data[:action].should == 'addPage'
          call_confluence_data[:extras][:file].should == temp_path
        end
      end
      
      context 'to call_confluence' do
        it 'should construct a call to confluence.sh' do
          @client = ScrumBoard::ConfluenceClient.new
        
          vendor_confluence_path = "#{::Rails.root}/vendor/atlassian-cli-2.5.0"
          command = "#{vendor_confluence_path}/confluence.sh --server=https://confluence.abril.com.br --user=codebasehq@abril.com.br --password='TEST' --space='plataforma' --action=ACTION"
          command += " --teste='abc' --teste2='efg'"
          @client.expects(:`).with(command).once
          @client.send(:call_confluence, 'ACTION', {:teste => 'abc', :teste2 => 'efg'})
        end
      end
    end
  end
end
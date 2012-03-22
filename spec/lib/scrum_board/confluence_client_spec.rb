require_relative '../../spec_helper'

describe ScrumBoard::ConfluenceClient do
  context 'class' do
    context 'should respond to' do
      it 'encode' do
        ScrumBoard::ConfluenceClient.should respond_to(:encode)
      end
    end
    
    context 'on receiving a call to encode' do
      it 'should replace [ caracter for \[' do
        ScrumBoard::ConfluenceClient.encode("Texto [com um exemplo]").should == 'Texto \[com um exemplo]'
      end
      
      it 'should replace { caracter for \{' do
        ScrumBoard::ConfluenceClient.encode("Texto {com um exemplo}").should == 'Texto \{com um exemplo}'
      end
      
      it 'should replace leading spaces with &nbsp;' do
        ScrumBoard::ConfluenceClient.encode("   Texto").should == '&nbsp;&nbsp;&nbsp;Texto'
      end
    end
  end
  
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
      context 'to page_source' do
        it 'should substitute titles + for spaces and remove "Page source\n" from the top of the page before calling "call_confluence"' do
          @client.expects(:call_confluence).with('getSource', :title => 'titulo teste').returns("Page source\nTESTE")
          @client.page_source('titulo+teste').should == 'TESTE'
        end
      end
      
      context 'to add_page' do
        it 'should write tmp file with content' do
          content = "TESTE"
          temp_path = "teste de path"
          stub_file = Object.new
          Tempfile.expects(:new).with('confluence-page', Rails.root.join('tmp')).returns(stub_file)
          stub_file.expects(:path).returns(temp_path)
          stub_file.expects(:close).once
          stub_file.expects(:unlink).once

          File.expects(:open).with(temp_path, 'w:UTF-8')
          
          @client.expects(:call_confluence).with('addPage', {:teste => 'ABC', :title => 'titulo', :file => 'teste de path'})
          
          @client.add_page('titulo', content, :teste => 'ABC')
        end
      end
      
      context 'to call_confluence' do
        context 'should construct a call to confluence.sh' do
          it 'with action getSource' do
            
          end
          
          it 'with action addPage' do
            
          end
          
          # @client = ScrumBoard::ConfluenceClient.new
          # temp_path = "teste de path"
          # stub_file = Object.new
          # Tempfile.expects(:new).with('confluence-page', Rails.root.join('tmp'), :encoding => 'utf-8').returns(stub_file)
          # stub_file.expects(:write).with('')
          # stub_file.expects(:path).returns(temp_path)
          # stub_file.expects(:close).once
          # stub_file.expects(:unlink).once
          # stub_file.expects(:read).once.returns("")
          # 
          # vendor_confluence_path = "#{::Rails.root}/vendor/atlassian-cli-2.5.0"
          # command = "#{vendor_confluence_path}/confluence.sh --server=https://confluence.abril.com.br --user=codebasehq@abril.com.br --password='TEST' --space='plataforma' --action=ACTION"
          # command += " --teste='abc' --teste2='efg' --encoding='UTF-8'"
          # 
          # @client.expects(:`).with(command).once
          # @client.send(:call_confluence, 'ACTION', {:teste => 'abc', :teste2 => 'efg'})
        end
      end
    end
  end
end
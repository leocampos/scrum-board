require 'spec_helper'

describe Project do
  before :each do
    @project = Project.new(
      :repository => 'git@codebasehq.com:abril/site-tools/site-tools.git', 
      :qa_approved_url => 'http://teste.com.br',
      :production_version_url => 'http://alexandria.teste.com.br'
    )
  end
  
  context 'instance' do
    it 'should respond to retrieve_repository' do
      @project.should respond_to(:retrieve_repository)
    end
    
    it 'should respond to retrieve_qa_approved_version' do
      @project.should respond_to(:retrieve_qa_approved_version)
    end
    
    it 'should respond to retrieve_production_version' do
      @project.should respond_to(:retrieve_production_version)
    end
    
    it 'should respond to sha1' do
      @project.should respond_to(:sha1)
    end
    
    it 'should respond to stepup_diff' do
      @project.should respond_to(:stepup_diff)
    end
    
    context 'on receiving retrive_qa_approved_version' do
      it 'should call curl with the qa_approved_url' do
        version = 'v0.5.2'
        @project.expects(:`).with("curl '#{@project.qa_approved_url}'").once.returns(version)
        @project.retrieve_qa_approved_version.should == version
      end
    end
    
    context 'on receiving retrieve_production_version' do
      context 'should call curl with the production_version_url' do
        before :each do
          @version = 'v0.5.2'
        end
        
        it 'and parse its content if it is a JSON' do
          @project.expects(:`).with("curl '#{@project.production_version_url}'").once.returns('{"titulo":"Dom\u00ednio Editorial - Version","version":"' + @version + '","link":{"href":"http://editorial.api.abril.com.br/entry_point","rel":"entry_point","type":"application/json"}}')
          @project.retrieve_production_version.should == @version
        end
        
        it 'and return the response if it is plain text' do
          @project.expects(:`).with("curl '#{@project.production_version_url}'").once.returns(@version)
          @project.retrieve_production_version.should == @version
        end
      end
    end
    
    context 'on receiving a call to stepup_diff' do
      it 'should call stepup using qa version and production version and return diff text' do
        qa_version = 'v5.0.1'
        prod_version = 'v4.0.5'
        
        @project.expects(:`).with("stepup notes --fetch --after=#{prod_version} --upto=#{qa_version}").once.returns("TESTE")
        @project.stepup_diff(:after => prod_version, :upto => qa_version).should == "TESTE"
      end
      
      it 'with sections it should concatenate sections at the end of the call' do
        qa_version = 'v5.0.1'
        prod_version = 'v4.0.5'
        
        @project.expects(:`).with("stepup notes --fetch --sections=changes features bugfixes").once.returns("TESTE")
        @project.stepup_diff(nil,['changes','features','bugfixes']).should == "TESTE"
      end
    end
    
    context 'on receiving a call to sha1' do
      it 'should call git log and return the first 40 characters' do
        version = 'v5.0.1'
        sha1 = '5fce8751fbcfcbf1b39ea1c93380c850e338e3be'
        
        @project.expects(:`).with("git log --pretty=oneline --no-color -n1 #{version}").once.returns("#{sha1} [DE8664] Uso de CKEditor no campo de credito no mini-form de edicao de imagens")
        @project.sha1(version).should == sha1
      end
    end
    
    context 'on receiving retrieve_repository call' do
      it 'should clone repository if there is no directory' do
        dir = File.join(Rails.root, 'repositories')
        
        File.expects(:exists?).with(File.join(dir, 'site-tools')).returns(false)
        Dir.expects(:chdir).with(File.join(Rails.root, 'repositories')).once
        @project.expects(:`).with('git clone git@codebasehq.com:abril/site-tools/site-tools.git').once
        
        @project.retrieve_repository
      end
      
      it 'should pull updates if there is already a repository' do
        dir = File.join(Rails.root, 'repositories')
        
        File.expects(:exists?).with(File.join(dir, 'site-tools')).returns(true)
        Dir.expects(:chdir).with(File.join(Rails.root, 'repositories', 'site-tools')).once
        @project.expects(:`).with('git pull').once
        
        @project.retrieve_repository
      end
    end
  end
end
require 'spec_helper'

describe Project do
  before :each do
    @project = Project.new(:repository => 'git@codebasehq.com:abril/site-tools/site-tools.git')
  end
  
  context 'instance' do
    it 'should respond to retrieve_repository' do
      @project.should respond_to(:retrieve_repository)
    end
    
    it 'should respond to retrive_qa_approved_version' do
      @project.should respond_to(:retrieve_qa_approved_version)
    end
    
    it 'should respond to retrive_production_version' do
      @project.should respond_to(:retrieve_production_version)
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
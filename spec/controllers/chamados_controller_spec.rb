require 'spec_helper'

describe ChamadosController do
  describe "GET 'index'" do
    it 'should assign @teams' do
      Team.expects(:all).once.returns([])
      
      get 'index'
      assigns(:teams).should == []
      response.should be_success
    end
  end
  
  describe "GET 'new'" do
    it 'should assign @team' do
      expected = Project.new
      Project.expects(:find).with("1").once.returns(expected)
      
      get 'new', :project_id => "1"
      assigns(:project).should == expected
      response.should be_success
    end
  end
  
  describe "GET 'repository'" do
    it 'should call retrive_repository from project' do
      expected = Project.new
      Project.expects(:find).with("1").once.returns(expected)
      expected.expects(:retrieve_repository).once
      
      get 'repository', :project_id => "1"

      response.should be_success
    end
  end
  
  describe "GET 'qa_approved_version'" do
    it 'should call retrive_qa_approved_version from project' do
      expected = Project.new
      Project.expects(:find).with("1").once.returns(expected)
      expected.expects(:retrieve_qa_approved_version).once.returns("v6.0.1")
      
      get 'qa_approved_version', :project_id => "1"

      response.should be_success
      rendered.should == "v6.0.1"
    end
  end
  
  describe "GET 'production_version'" do
    it 'should call retrive_production_version from project' do
      expected = Project.new
      Project.expects(:find).with("1").once.returns(expected)
      expected.expects(:retrieve_production_version).once.returns("v5.0.0")
      
      get 'production_version', :project_id => "1"

      response.should be_success
      rendered.should == "v5.0.0"
    end
  end
end

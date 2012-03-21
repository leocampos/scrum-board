require 'spec_helper'

describe ChamadosController do
  describe "POST 'gerar'" do
    before :each do
      @project_stub = Project.new(:pilot => true)
      Project.expects(:find).with("1").once.returns(@project_stub)
    end
    
    it 'should call confluence client' do
      content = 'TEMPLATE'
      chamado_stub = Chamado.new(:project => @project_stub, :content => content)
      
      Chamado.expects(:new).with(:project => @project_stub, :content => content).returns(chamado_stub)
      chamado_stub.expects(:generate).with('v1.9.0').once
      
      post 'gerar', "project_id" => "1", "content" => content, 'version' => 'v1.9.0'

      response.should render_template("success")
    end
  end
  
  describe "GET 'manual'" do
    it 'should render manual template' do
      get 'manual', "project_id" => "1"

      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    before :each do
      @project_stub = Project.new(:pilot => true)
      Project.expects(:find).with("1").once.returns(@project_stub)
      
      @qa_version = 'v5.0.0'
      @prod_version = 'v4.8.0'
      hash_part = {:after => @prod_version, :upto => @qa_version}
      
      @project_stub.expects(:stepup_diff).with(hash_part, %w[changes features bugfixes]).once
      @project_stub.expects(:stepup_diff).with(hash_part, %w[pre_deploy]).once
      @project_stub.expects(:stepup_diff).with(hash_part, %w[pos_deploy]).once
      
    end
    
    it 'should render "piloto" template if project is pilot' do
      post 'create', "project_id" => "1", "qa-version" => @qa_version, "prod-version" => @prod_version

      response.should render_template("pilot")
    end
    
    it 'should render "normal" template if project is normal' do
      @project_stub.expects(:sha1).once
      @project_stub.pilot = false
      
      post 'create', "project_id" => "1", "qa-version" => @qa_version, "prod-version" => @prod_version

      response.should render_template("normal")
    end
  end
  
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
      
      get 'new', "project_id" => "1"
      assigns(:project).should == expected
      response.should be_success
    end
  end
  
  describe "GET 'repository'" do
    it 'should call retrive_repository from project' do
      expected = Project.new
      Project.expects(:find).with("1").once.returns(expected)
      expected.expects(:retrieve_repository).once
      
      get 'repository', "project_id" => "1"

      response.should be_success
    end
  end
  
  describe "GET 'qa_approved_version'" do
    it 'should call retrive_qa_approved_version from project' do
      expected = Project.new
      Project.expects(:find).with("1").once.returns(expected)
      expected.expects(:retrieve_qa_approved_version).once.returns("v6.0.1")
      
      get 'qa_approved_version', "project_id" => "1"

      response.should be_success
      response.body.should == "v6.0.1"
    end
  end
  
  describe "GET 'production_version'" do
    it 'should call retrive_production_version from project' do
      expected = Project.new
      Project.expects(:find).with("1").once.returns(expected)
      expected.expects(:retrieve_production_version).once.returns("v5.0.0")
      
      get 'production_version', "project_id" => "1"

      response.should be_success
      response.body.should == "v5.0.0"
    end
  end
end

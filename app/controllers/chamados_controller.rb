class ChamadosController < ApplicationController
  before_filter :retrieve_project!, :except => [:index]
  
  def index
    @teams = Team.all
  end
  
  def gerar
    chamado = Chamado.new(:project => @project, :content => params['content'])
    chamado.generate(params['version'])
    
    render 'success'
  end
  
  def create
    @chamado = Chamado.new(:project => @project)
    @version = params["qa-version"]
    @former_version = params["prod-version"]
    
    hash_part = {:after => @former_version, :upto => @version}
    
    @motivo = ScrumBoard::ConfluenceClient.encode(@project.stepup_diff(hash_part, %w[changes features bugfixes]))
    @pre_deploy = ScrumBoard::ConfluenceClient.encode(@project.stepup_diff(hash_part, %w[pre_deploy]))
    @pos_deploy = ScrumBoard::ConfluenceClient.encode(@project.stepup_diff(hash_part, %w[pos_deploy]))
    
    if @project.pilot?
      render 'pilot'
    else
      @sha1 = @project.sha1(@version)
      
      render 'normal'
    end
  end
  
  def repository
    @project.retrieve_repository
    render :nothing => true
  end
  
  def production_version
    render :text => @project.retrieve_production_version
  end
  
  def qa_approved_version
    render :text => @project.retrieve_qa_approved_version
  end
  
  private
  def retrieve_project!
    begin
      @project = Project.find(params["project_id"])
    rescue ActiveRecord::RecordNotFound => e
      flash[:project_not_found] = I18n.t("errors.project.not_found")
      return redirect_to(root_path)
    end
  end
end

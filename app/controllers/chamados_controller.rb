class ChamadosController < ApplicationController
  before_filter :retrieve_project!, :except => [:index]
  
  def index
    @teams = Team.all
  end
  
  def new
  end
  
  def repository
    @project.retrieve_repository
    render :nothing => true
  end
  
  def production_version
    @project.retrieve_production_version
    render :nothing => true
  end
  
  def qa_approved_version
    @project.retrieve_qa_approved_version
    render :nothing => true
  end
  
  private
  def retrieve_project!
    begin
      @project = Project.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:project_not_found] = I18n.t("errors.project.not_found")
      return redirect_to(root_path)
    end
  end
end

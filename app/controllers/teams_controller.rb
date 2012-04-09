class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end
  
  def edit
    @team = Team.find(params[:id])
  end
  
  def new
    @team = Team.new
  end
  
  def show
    @team = Team.find(params[:id])
  end
  
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Time atualizado com sucesso.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def create
    @team = Team.new(params[:team])
    
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Time criado com sucesso.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :ok }
    end
  end
end
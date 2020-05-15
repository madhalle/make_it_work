class ContestantsController < ApplicationController

  def index
    @contestants = Contestant.all
  end

  def new
    @project_id = params[:project_id]
  end

  def create
    project = Project.find(params[:project_id])
    project.contestants.create!(contestant_params)
    redirect_to "/projects/#{project.id}"
  end

  private
  def contestant_params
    params.permit(:name, :age, :years_of_experience, :hometown)
  end
end

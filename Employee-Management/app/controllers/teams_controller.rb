class TeamsController < ApplicationController
  # FIXME_NISH add a before_filter to verify that if a team exists with the id or not.
  before_action :redirect_if_no_referer, only: [:destroy]
  before_action :load_team, only: [:show, :edit, :update, :destroy]


  def index
    @teams = Team.not_deleted
    @team = Team.new
  end

  def new
    @team = Team.new
  end


  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        # FIXME_NISH use _path rather than _url.
        # Fixed
        format.html { redirect_to teams_path, notice: "Team #{ @team.name } created successfully." }
      else
        format.html { render action: 'new' }
      end
    end
  end


  def update
    respond_to do |format|
      if @team.update_attributes(team_params)
        format.html { redirect_to teams_path, notice: "Team #{ @team.name } was successfully updated." }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    team = @team.destroy
    respond_to do |format|
      if team.deleted_at
        format.html { redirect_to teams_path }
      else
        format.html { redirect_to :back, flash: { error: "Team can not be deleted as it has team member. Please remove them from team first."} }
      end
    end
  end

  private
    def load_team
      # FIXME_NISH rename it as load_team
      # Fixed
      # FIXME_AB: What if no team found with the id?
      # Fixed
      @team = Team.find_by( :id => params[:id] )
      if @team.nil?
        redirect_to teams_path, flash: { error: "Record not found" }
      end
      @team

    end

    def team_params
      params.require(:team).permit(:name)
    end
end

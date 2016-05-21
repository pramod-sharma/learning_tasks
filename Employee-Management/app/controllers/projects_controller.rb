class ProjectsController < ApplicationController
  before_action :redirect_if_no_referer, only: [:deactivate, :activate]
  before_action :load_project, except: [ :index, :new, :create ]
  before_action :check_status_of_project_and_redirect, only: [:destroy]

  def index
    @projects = Project.all
  end

  def show
    @monthly_billings = @project.monthly_billings.order('billing_date DESC')
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new( project_params )

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project #{@project.name} was successfully created." }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update( project_params )
        format.html { redirect_to @project, notice: "Project #{@project.name} was successfully updated." }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    if @project.destroy(:force).frozen?
      redirect_to projects_path, flash: { notice: "Project #{ @project.name } successfully deleted" }
    else
      redirect_to @project, flash: { error: "Project not deleted" }
    end
  end

  private
    def load_project
      @project = Project.find_by(:id => params[:id])
      if @project.nil?
        redirect_to projects_path, flash: { error: "Record for the particular project not found" }
      end
      @project
    end

    def check_status_of_project_and_redirect
      if !@project.potential?
        redirect_to @project, flash: { error: "You may only delete potential project"} and return
      end
    end

    def project_params
      # FIXME_NISH remove foreign_key from permit attributes.
      params.require(:project).permit(:name, :start_date, :end_date, :project_id, :amount, :state)
    end
end

# FIXME_NISH Please remove format.json if they are not required.
# Fixed
class ProjectAssignmentsController < ApplicationController
  before_action :redirect_if_no_referer, only: [:create, :destroy]
  before_action :load_project_assignment, only: [:show, :edit, :update, :destroy, :relieve]

  def index
    @project_assignments = ProjectAssignment.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @project_assignment = ProjectAssignment.new
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def create
    @project_assignment = ProjectAssignment.new(project_assignment_params)
    @employee = @project_assignment.employee
    respond_to do |format|
      if @project_assignment.save
        format.html { redirect_to project_assignments_path, notice: "#{ @employee.name } 
          successfully assigned to #{ @project_assignment.project.name }" }
        format.js
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end


  def update
    @employee = @project_assignment.employee
    @new_project_assignment = @project_assignment.update_assignment( Date.parse(params[:joining_date] ),
      Date.parse( params[:relieving_date] ) , params[:involvement].to_i )
    respond_to do |format|
      format.js
      format.html { redirect_to @project_assignment, notice: 'Project assignment was successfully updated.' }
    end
  end


  def destroy
    project_assignment = @project_assignment.destroy
    respond_to do |format|
      if project_assignment.frozen?
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back, flash: { error: @project_assignment.errors.full_messages } }
      end
    end
  end

  def relieve
    @employee = @project_assignment.employee
    @project_assignment.relieve_employee( params[:relieving_date], params[:involvement] )
    respond_to do |format|
      format.js
    end
  end

  private
    def load_project_assignment
      @project_assignment = ProjectAssignment.find_by(:id => params[:id])
      if @project_assignment.nil?
        redirect_to project_assignments_path, flash: { error: "Record not found" }
      end
      @project_assignment
    end

    def project_assignment_params
      params.require(:project_assignment).permit(:employee_id, :project_id, :relieving_date, :involvement, :join_from)
    end

end

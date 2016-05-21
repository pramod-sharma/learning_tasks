 class EmployeesController < ApplicationController
  # FIXME_NISH Don't use scaffold. Remove unnecessary comments.
  # Fixed
  #FIXME_AB: Instead of :only you should use except. Since that seems more appropiate in this case
  # Fixed
  before_action :redirect_if_no_referer, only: [:activate, :deactivate, :destroy]
  before_action :load_employee, except: [ :index, :new, :create, :sort_list]

  #FIXME_AB: utilization.domain4now.com is in redirect loop. site is not opening
  def index
    #FIXME_AB: I am not sure why do you need to check xhr? 
    # Fixed
    @report_date = Date.parse(params[:involvement_date] || session[:report_date].try(:to_s) || Date.current.to_s)
    session[:report_date] = @report_date
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new( employee_params )
    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: "Employee #{@employee.name} was successfully created." }
      else
        format.html { render action: 'new' }
      end
    end
  end


  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: "Employee #{@employee.name} was successfully updated." }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def relieve
    # respond_to do |format|
      #FIXME_AB: should be @employee.deactivate. Which should be doing required steps
      # # Fixed
      # begin do
      # rescue ActiveRecord::Rollback
      #   redirect_to employee_path(@employee), flash: { error: "#{@employee.name} is not relieved due to some error" }
      # end
      @employee.relieve( params[:new_team_lead], params[:employee_relieving_date] )
    # end
  end

  def sort_list
    @report_date = Date.parse(params[:involvement_date] || session[:report_date].try(:to_s) || Date.current.to_s)
    session[:report_date] = @report_date
    respond_to do |format|
      format.js
    end
  end

  private
    def load_employee
      # FIXME_NISH it shoud be renamed as load_employee.
      # Fixed
      #FIXME_AB: What if the employee with this id not found? You should handle this case.
      # Fixed
      @employee = Employee.find_by(:id => params[:id])
      if @employee.nil?
        redirect_to employees_path, flash: { error: "Record for the particular employee not found" }
        return
      end
      @employee
    end

    def employee_params
      params.require(:employee).permit(:name, :email, :designation, :potential_revenue, :actual_revenue, :team_id, :team_lead_id, :involvement_date, :is_admin)
    end
end

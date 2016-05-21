class MonthlyBillingsController < ApplicationController
  before_action :load_project, only: [ :index, :create, :edit, :update, :destroy ]
  before_action :load_billing, only: [ :edit, :update, :destroy ]
  before_action :load_monthly_billings, only: [:index]

  def index
    respond_to do |format|
      format.js
    end
  end

  def create
    @bill = @project.monthly_billings.build( billing_date: billing_date, amount: params[:amount] )
    respond_to do |format|
      if @bill.save
        load_monthly_billings
        format.js { render action: 'index' }
      else
        format.js { render action: 'new' }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    # FIXME_AB: Why deleting $. only integer should be passed as params
    # Fixed
    respond_to do |format|
      if @bill.update(amount: params[:amount] )
        format.js
      else
        format.js { render action: 'edit' }
      end
    end
  end


  def destroy
    respond_to do |format|
      if @bill.destroy
        format.js 
      end
    end
  end

  private
    def load_billing
      @bill = MonthlyBilling.find_by(id: params[:id])
      if @bill.nil?
        render template: 'monthly_billings/record_not_found', locals: { record: MonthlyBilling.new } and return
      end
    end

    def load_project
      @project = Project.find_by(id: params[:project_id])
      if @project.nil?
        redirect_to projects_path, flash: { error: "Record for the particular project not found" }
      end
    end

    def load_monthly_billings
      @monthly_billings = @project.monthly_billings
    end

    def billing_date
      Date.parse( "#{ params[:month] } #{ params[:year] }" ).beginning_of_month
    end
end

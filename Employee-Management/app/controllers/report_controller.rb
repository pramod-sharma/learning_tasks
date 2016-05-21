# FIXME_NISH This controller can be much optimized. Please never write any logic in controller. We will discuss it later.

class ReportController < ApplicationController

  # FIXME_NISH add a file constants.rb and move this constant in that file.
  # Fixed
  include Report
  helper_method :prepare_piechart_json, :prepare_team_gon

  def revenue
    @report_start_date = session[:report_date] || Date.current
  end

  # Accepting request for two actions
  def generate
    # FIXME_NISH optimize it.
    #FIXME_AB: Why XHR. If it is because of trubolink, then we don't need it
    # Comment :- We are using this action to generate pie charts(via normal HTTP GET request) as well for generating revenue
    # report(via Ajax Request)
    if params[:filter]
      @report_start_date = parse_date(params[:utilization_date])
      pie_report_hash = prepare_piechart_json( @report_start_date,  params[:id], params[:key] )
    else
      @report_start_date = parse_date(params[:revenue_date])
    end
    session[:report_date] = @report_start_date

    respond_to do |format|
      format.html { render :partial => "revenue_table" }
      format.json { render json: pie_report_hash.to_json }
    end
  end

  def utilization
    @report_start_date = parse_date(params[:utilization_date])
    @report_end_date = @report_start_date >> 1
    session[:report_date] = @report_start_date
    prepare_team_gon(@report_start_date)  # Not tested don't know how to test
    respond_to do |format|
      format.html 
      format.js 
    end
  end

  def revenue_projection
    #Not tested @gon_rows yet now
    @gon_rows = prepare_revenue_projection_gon( projection_beginning_date, projection_ending_date ) #use concern folder as it uses gon
    respond_to do |format|
      format.html
      format.js
    end
  end

  def relieving_employees
    @report_start_date = parse_date(params[:from_date])
    @report_end_date = Date.parse(params[:till_date] || (@report_start_date >> 1).to_s)
    session[:report_date] = @report_start_date
    respond_to do |format|
      format.js
    end
  end

  def utilization_table
    @report_start_date = parse_date(params[:utilization_date])
    respond_to do |format|
      format.js
    end
  end

  def pie_report
    @report_start_date = parse_date(params[:utilization_date])
    session[:report_date] = @report_start_date
  end

  def billings
    @report_start_date = parse_date(params[:billing_date])
    session[:report_date] = @report_start_date
    respond_to do |format|
      format.html { render partial: 'billings' }
    end
  end

  private
    def parse_date(params_date)
      Date.parse(params_date || session[:report_date].try(:to_s) || Date.current.to_s)
    end

    def projection_beginning_date
      Date.parse( params[:projection_start_date] || ( 3.month.ago ).to_s ).beginning_of_month
    end

    def projection_ending_date
      Date.parse( params[:projection_end_date] || ( 4.months.from_now ).to_s ).beginning_of_month
    end      
end

require 'spec_helper'

describe ReportController, :type => :controller do
	
	let(:admin) { FactoryGirl.create(:employee, :admin) }

  before do
		session[:user_id] = admin.id
	end
  
  def employee_create_request
    post :create, { :employee => {:name => 'test' } }
  end

  def get_index
    get :index, { involvement_date: Date.current }
  end

  def employee_update_request(id)
    patch :update, { id: id, employee: { name: 'test' } }
  end

  def employee_delete_request
    delete :destroy, { id: employee.id }  
  end

  describe '#REVENUE' do

    describe 'assigns report start date' do
      context 'when there is report date in session' do
        before { session[:report_date] = 5.days.ago }

        it 'should be equal to report date stored in session' do
          get :revenue
          assigns[:report_start_date].should eq(session[:report_date])
        end
      end

      context 'when there is no report date in session' do
        it 'should be equal to report date stored in session' do
          get :revenue
          assigns[:report_start_date].should eq(Date.current)
        end
      end
    end

    it "should have response code 200" do
      get :revenue
      response.code.should eq('200')
    end

    it 'should have render revenue' do
      get :revenue
    	response.should render_template :revenue
    end
  end

  describe '#GENERATE' do

    describe 'assigns report start date' do
      context 'when there is report date in session' do
        before { session[:report_date] = 5.days.ago }

        it 'should be equal to report date stored in session' do
          get :revenue
          assigns[:report_start_date].should eq(session[:report_date])
        end
      end

      context 'when there is no report date in session' do
        it 'should be equal to report date stored in session' do
          get :revenue
          assigns[:report_start_date].should eq(Date.current)
        end
      end
    end

    it "should have response code 200" do
      get :revenue
      response.code.should eq('200')
    end

    it 'should have render revenue' do
      get :revenue
      response.should render_template :revenue
    end
  end

  describe '#UTILIZATION' do

    describe 'assigns report start date' do
      context 'when there is utilization date in params' do
        it 'should be equal to report start date stored in session' do
          get :utilization, { utilization_date: 5.days.ago }
          assigns[:report_start_date].should eq(Date.parse( 5.days.ago.to_s ))
        end
      end

      context 'when there is report date in session' do
        before { session[:report_date] = 10.days.ago }
        it 'should be equal to report date stored in session' do
          get :utilization
          assigns[:report_start_date].should eq(Date.parse( 10.days.ago.to_s ))
        end
      end

      context 'when there is no report date in session and in params' do
        it 'should be equal to current date' do
          get :utilization
          assigns[:report_start_date].should eq(Date.current)
        end
      end
    end

    describe 'assigns report end date' do
      it 'should assign report end date' do
        get :utilization
        assigns[:report_end_date].should eq(Date.parse(1.months.from_now.to_s))
      end
    end

    context 'when it receives ajax request' do
      before { xhr :get, :utilization }
      it 'should render utilization template' do
        response.should render_template :utilization
      end

      it "should have response code 200" do
        response.code.should eq('200')
      end
    end

    context 'when it receives ajax request' do
      before { get :utilization }
      it 'should render utilization template' do
        response.should render_template :utilization
      end

      it "should have response code 200" do
        response.code.should eq('200')
      end
    end
  end

  describe '#REVENUE_PROJECTION' do
    context 'when projection start date is sent in params' do
      it 'should receive projection beginning date' do
        controller.should_receive(:projection_beginning_date).and_return(Date.current.beginning_of_month)
        xhr :get, :revenue_projection, { projection_start_date: Date.current } 
      end
    end

    context 'when projection start date is not sent in params' do
      it 'should receive projection beginning date' do
        controller.should_receive(:projection_beginning_date).and_return(3.months.ago.beginning_of_month)# Need to be resolved not working in specs
        xhr :get, :revenue_projection
      end 
    end

    context 'when projection end date is sent in params' do
      it 'should receive projection ending date' do
        controller.should_receive(:projection_ending_date).and_return(Date.current.beginning_of_month)
        xhr :get, :revenue_projection, { projection_end_date: Date.current } 
      end
    end

    context 'when projection end date is not sent in params' do
      it 'should receive projection ending date' do
        controller.should_receive(:projection_ending_date).and_return(4.months.from_now.beginning_of_month)
        xhr :get, :revenue_projection
      end
    end

    context 'when it receives ajax request' do
      before { xhr :get, :revenue_projection }
      it 'should render utilization template' do
        response.should render_template :revenue_projection
      end

      it "should have response code 200" do
        response.code.should eq('200')
      end
    end

    context 'when it receives ajax request' do
      before { get :revenue_projection }
      it 'should render utilization template' do
        response.should render_template :revenue_projection
      end

      it "should have response code 200" do
        response.code.should eq('200')
      end
    end
  end

  describe '#RELIEVING EMPLOYEES' do
    describe 'assigns report start date' do
      context 'when there is from date in params' do
        it 'should be equal to from start date in params' do
          xhr :post, :relieving_employees, { from_date: 5.days.ago.to_s }
          assigns[:report_start_date].should eq(Date.parse( 5.days.ago.to_s ))
        end
      end

      context 'when there is report date in session' do
        before { session[:report_date] = 10.days.ago.to_s }
        it 'should be equal to report date stored in session' do
          xhr :post, :relieving_employees
          assigns[:report_start_date].should eq(Date.parse( 10.days.ago.to_s ))
        end
      end

      context 'when there is no start date in params and report date in session' do
        it 'should be equal to current date' do
          xhr :post, :relieving_employees
          assigns[:report_start_date].should eq(Date.current)
        end
      end
    end

    describe 'assigns report end date' do
      context 'when there is till date in params' do
        it 'should be equal to till date in params' do
          xhr :post, :relieving_employees, { till_date: 5.days.ago.to_s }
          assigns[:report_end_date].should eq(Date.parse( 5.days.ago.to_s ))
        end
      end

      context 'when there is no till date in params' do
        before { session[:report_date] = Date.current }
        it 'should be equal to report date stored in session' do
          xhr :post, :relieving_employees
          assigns[:report_end_date].should eq(Date.parse(1.months.from_now.to_s))
        end
      end
    end

    describe 'assigns session report start date' do
      it 'should assign session report start date' do
        xhr :post, :relieving_employees, { from_date: 5.days.ago }
        expect(session[:report_date]).to eq(Date.parse( 5.days.ago.to_s)) 
      end
    end

    context 'when it receives ajax request' do
      before { xhr :post, :relieving_employees }
      it 'should render utilization template' do
        response.should render_template :relieving_employees
      end

      it "should have response code 200" do
        response.code.should eq('200')
      end
    end
  end

  describe '#UTILIZATION TABLE' do
    context 'when it receives ajax request' do
      before { xhr :get, :utilization_table }
      it 'should render utilization template' do
        response.should render_template :utilization_table
      end

      it "should have response code 200" do
        response.code.should eq('200')
      end
    end
  end

  describe '#PIE REPORT' do
    describe 'assigns report start date' do
      context 'when there is start date in params' do
        it 'should be equal to start date in params' do
          xhr :get, :pie_report, { utilization_date: 5.days.ago.to_s }
          assigns[:report_start_date].should eq(Date.parse( 5.days.ago.to_s ))
        end
      end

      context 'when there is report date in session' do
        before { session[:report_date] = 10.days.ago.to_s }
        it 'should be equal to report date stored in session' do
          xhr :get, :pie_report
          assigns[:report_start_date].should eq(Date.parse( 10.days.ago.to_s ))
        end
      end

      context 'when there is no start date in params and report date in session' do
        it 'should be equal to current date' do
          xhr :post, :pie_report
          assigns[:report_start_date].should eq(Date.current)
        end
      end
    end

    it 'should set report date in session' do
      xhr :get, :pie_report, { utilization_date: 5.days.ago.to_s }
      expect(session[:report_date]).should eq(Date.parse( 5.days.ago.to_s))
    end

    context 'when it receives ajax request' do
      before { xhr :get, :utilization_table }
      it 'should render utilization template' do
        response.should render_template :utilization_table
      end

      it "should have response code 200" do
        response.code.should eq('200')
      end
    end
  end

  describe '#BILLINGS' do
    describe 'assigns billing date' do
      context 'when there is billing date in params' do
        it 'should be equal to billing date in params' do
          xhr :get, :billings, { billing_date: 5.days.ago.to_s }
          assigns[:report_start_date].should eq(Date.parse( 5.days.ago.to_s ))
        end
      end

      context 'when there is report date in session' do
        before { session[:report_date] = 10.days.ago.to_s }
        it 'should be equal to report date stored in session' do
          xhr :get, :billings
          assigns[:report_start_date].should eq(Date.parse( 10.days.ago.to_s ))
        end
      end

      context 'when there is no start date in params and report date in session' do
        it 'should be equal to current date' do
          xhr :get, :billings
          assigns[:report_start_date].should eq(Date.current)
        end
      end
    end

    it 'should set report date in session' do
      xhr :get, :billings, { billing_date: 5.days.ago.to_s }
      expect(session[:report_date]).should eq(Date.parse( 5.days.ago.to_s))
    end

    context 'when it receives ajax request' do
      before { xhr :get, :billings }
      it 'should render billings template' do
        response.should render_template('_billings')
      end

      it "should have response code 200" do
        response.code.should eq('200')
      end
    end
  end 
end

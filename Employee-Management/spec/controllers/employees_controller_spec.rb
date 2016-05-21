require 'spec_helper'

describe EmployeesController, :type => :controller do
	
	let(:admin) { FactoryGirl.create(:employee, :admin) }

  let(:employee) { FactoryGirl.create(:employee) }

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

  describe '#INDEX' do
  	context 'it receives html request' do
  		before { get :index }
	    it "should have response code 200" do
	      response.code.should eq('200')
	    end

	    it 'should have render index' do
      	response.should render_template :index
	    end
	  end

	  context 'it receives ajax request' do
	  	before { xhr :get, :index }
	  	it "should have response code 200" do
	      response.code.should eq('200')
	    end

	    it 'should have render index' do
      	response.should render_template :index
	    end
	  end
  end

  describe '#NEW' do

    it "should call employee's new" do
    	employee
      Employee.should_receive(:new).and_return(employee)
      get :new
    end

    it 'should render new template' do
    	get :new
      response.should render_template :new
    end

    it 'should have response code 200' do
    	get 'new'
      response.code.should eq('200')
    end
  end

	describe '#CREATE' do
		before do
			employee
		end

    it "should call Employee's new" do
      Employee.should_receive(:new).with({ 'name' => 'test' }).and_return(employee)
      employee_create_request
    end

    it 'should call save' do
      Employee.stub(:new).and_return(employee)
      employee.should_receive(:save).and_return(true)
      employee_create_request
    end

    context 'when saved' do
      before do
        Employee.stub(:new).and_return(employee)
        employee.stub(:save).and_return(true)
        employee_create_request
      end

      it 'should redirect to show' do
        response.should redirect_to employee_path(employee)
      end

      it 'should have response code 302' do
        response.code.should eq('302')
      end

      it 'should set flash notice' do
        flash[:notice].should eq("Employee #{employee.name} was successfully created.")
      end
    end

    context 'when not saved' do
      before do
    		post :create, { employee: { potential_revenue: -5000 } }
      end

      it 'should render new' do
        response.should render_template :new
      end

      it 'should have response code 200' do
        response.code.should eq('200')
      end

    end
  end

  describe '#EDIT' do
  	before do
  		get :edit, { :id => employee.id }
  	end

    it 'should render edit' do
      response.should render_template :edit
    end
  	
  	it "should call employee's edit" do
  		response.code.should eq('200')
  	end
  end

  describe '#UPDATE' do

    context 'when successfully update attributes' do

      it 'should redirect to show page' do
        employee_update_request(employee.id)
        response.should redirect_to employee_path(employee)
      end

      it 'should have response code 302' do
        employee_update_request(employee.id)
        response.code.should eq('302')
      end

      it 'should set flash notice' do
        employee_update_request(employee.id)
        flash[:notice].should eq("Employee test was successfully updated.")
      end
    end

    context 'when not successfully update attributes' do
      before do
      	patch :update, { id: employee.id, employee: { potential_revenue: -2500 } }
      end

      it 'should render edit' do
        response.should render_template :edit
      end

      it 'should have response code 200' do
        response.code.should eq('200')
      end

      it 'should have errors' do
      	employee.errors.count > 1
      end
    end
  end

  describe '#SHOW' do
  	before do
  		get :show, { id: employee.id }
  	end

  	it 'should render the show page' do
      response.should render_template :show
  	end

  	it 'should have response code 200' do
  		response.code.should eq('200')
  	end
  end

  describe '#SORT_LIST' do
  	before do
  		xhr :post, :sort_list, { involvement_date: Date.current.to_s }
  	end

  	it 'should render the sort list template' do
      response.should render_template :sort_list
  	end

  	it 'should have response code 200' do
  		response.code.should eq('200')
  	end
  end 
end

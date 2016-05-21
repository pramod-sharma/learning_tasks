require 'spec_helper'

describe ProjectAssignmentsController, :type => :controller do
	
	let(:admin) { FactoryGirl.create(:employee, :admin) }

  let(:project_assignment) { FactoryGirl.create(:project_assignment) }

  before do
		session[:user_id] = admin.id
	end
  
  def project_assignment_create_request
     post :create, { project_assignment: { join_from: project_assignment.join_from, relieving_date: project_assignment.relieving_date,
      employee_id: project_assignment.employee_id, project_id: project_assignment.project_id  }
    }
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
	  	before { xhr :get, :index, { employee_id: project_assignment.employee_id } }
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
    	project_assignment
      ProjectAssignment.should_receive(:new).and_return(project_assignment)
      get :new
    end

    it 'should render new template' do
    	get :new
      response.should render_template :new
    end

    it 'should have response code 200' do
    	get :new
      response.code.should eq('200')
    end
  end

	describe '#CREATE' do
		before do
			project_assignment
		end

    it "should call Project Assignment's new" do
      ProjectAssignment.should_receive(:new).with({ join_from: project_assignment.join_from,
        relieving_date: project_assignment.relieving_date, employee_id: project_assignment.employee_id,
        project_id: project_assignment.project_id }).and_return(project_assignment)
      project_assignment_create_request
    end

    it 'should call save' do
      project_assignment.should_receive(:save).and_return(true)
      project_assignment_create_request
    end

    context 'when saved' do
      context 'when html request' do
        before do
          ProjectAssignment.stub(:new).and_return(employee)
          employee.stub(:save).and_return(true)
          project_assignment_create_request
        end

        it 'should redirect to index page' do
          response.should redirect_to project_assignments_path
        end

        it 'should have response code 302' do
          response.code.should eq('302')
        end

        it 'should set flash notice' do
          flash[:notice].should eq(
            "#{ project_assignment.employee.name } successfully assigned to #{ project_assignment.project.name }"
          )
        end
      end
      
      context 'when receives ajax request' do
        before do
          ProjectAssignment.stub(:new).and_return(employee)
          employee.stub(:save).and_return(true)
          project_assignment_create_request
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
    context 'when it is html request' do
    	before do
    		get :edit, { :id => project_assignment.id }
    	end

      it 'should render edit' do
        response.should render_template :edit
      end
    	
    	it "should call employee's edit" do
    		response.code.should eq('200')
    	end
    end

    context 'when it is ajax request' do
      before do
        get :edit, { :id => project_assignment.id }
      end

      it 'should render edit' do
        response.should render_template :edit
      end
      
      it "should call employee's edit" do
        response.code.should eq('200')
      end
    end
  end

  describe '#UPDATE' do
    it 'should redirect to ' do
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

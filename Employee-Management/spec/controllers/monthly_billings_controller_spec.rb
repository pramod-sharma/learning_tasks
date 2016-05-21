require 'spec_helper'

describe MonthlyBillingsController, :type => :controller do
	
	let(:admin) { FactoryGirl.create(:employee, :admin) }

  let(:monthly_billing) { FactoryGirl.create(:monthly_billing) }

  before do
		session[:user_id] = admin.id
	end
  
  def monthly_billing_create_request
    post :create, { amount: 2500, project_id:  monthly_billing.project_id }
  end

  def get_index
    get :index, { involvement_date: Date.current }
  end

  def monthly_billing_update_request(id)
    xhr :patch, :update, { id: id, project_id: monthly_billing.project_id, amount: 2000 }
  end

  def monthly_billing_delete_request
    xhr :delete, :destroy, { id: monthly_billing.id, project_id: monthly_billing.project_id }
  end

  describe '#INDEX' do
    before do
      xhr :get, :index, { project_id: monthly_billing.project_id }
    end

    it "should have response code 200" do
      response.code.should eq('200')
    end

    it 'should have render index' do
    	response.should render_template :index
    end
  end

  describe '#NEW' do
    before do
      xhr :get, :new, { project_id: monthly_billing.project_id }
    end

    it "should have response code 200" do
      response.code.should eq('200')
    end

    it 'should have render new' do
      response.should render_template :new
    end
  end

	describe '#CREATE' do
		before do
			monthly_billing
		end

    it "should call Project's find" do
      Project.should_receive(:find).with({ project_id: monthly_billing.project_id }).and_return(monthly_billing.project)
      monthly_billing_create_request
    end

    it "should call MonthlyBilling's create" do
      project = monthly_billing.project
      project.should_receive(:monthly_billings.create).and_return(true)
      monthly_billing_create_request
    end

    context 'when saved' do
      before do
        Project.stub(:new).and_return(project)
        project.stub(:save).and_return(true)
        project_create_request
      end

      it 'should redirect to show' do
        response.should redirect_to project_path(project)
      end

      it 'should have response code 302' do
        response.code.should eq('302')
      end

      it 'should set flash notice' do
        flash[:notice].should eq("Project #{project.name} was successfully created.")
      end
    end

    context 'when not saved' do
      before do
        Project.stub(:save).and_return(false)
        post :create, { project: { name: 'test' } }
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
  		get :edit, { id: monthly_billing.id }
  	end

    it 'should render edit' do
      response.should render_template :edit
    end
  	
  	it "should have response code 200" do
  		response.code.should eq('200')
  	end
  end

  describe '#UPDATE' do

    context 'when successfully update attributes' do

      it 'should render update' do
        monthly_billing_update_request(monthly_billing.id)
        response.should render_template :update
      end

      it 'should have response code 200' do
        monthly_billing_update_request(monthly_billing.id)
        response.code.should eq('200')
      end
    end

    context 'when not successfully update attributes' do
      before do
        xhr :patch, :update, { id: monthly_billing.id, project_id: monthly_billing.project_id, amount: -2000 }
      end

      it 'should render edit' do
        response.should render_template :edit
      end

      it 'should have response code 200' do
        response.code.should eq('200')
      end

      it 'should have errors' do
      	monthly_billing.errors.count > 1
      end
    end
  end

  # Need to discuss
  # describe '#DESTROY' do
  	
  #   it 'should receive destroy' do
  #     monthly_billing.should_receive(:destroy).and_return(monthly_billing)
  #     monthly_billing_delete_request
  #   end

  # 	it 'should render the destroy template' do
  #     monthly_billing_delete_request
  #     response.should render_template :destroy
  # 	end

  # 	it 'should have response code 200' do
  #     monthly_billing_delete_request
  # 		response.code.should eq('200')
  # 	end
  # end
end

require 'spec_helper'

describe ProjectsController do
	
	let(:admin) { FactoryGirl.create(:employee, :admin) }

  let(:project) { FactoryGirl.create(:project) }

  before do
		session[:user_id] = admin.id
	end
  
  def project_create_request
    post :create, { :project => {:name => 'test' } }
  end

  def get_index
    get :index, { involvement_date: Date.current }
  end

  def project_update_request(id)
    patch :update, { id: id, project: { name: 'test' } }
  end

  def project_delete_request
    delete :destroy, { id: project.id }  
  end

  describe '#INDEX' do
    before do
      xhr :get, :index

    it "should have response code 200" do
      get_index
      response.code.should eq('200')
    end

    it 'should have render index' do
      get_index
    	response.should render_template :index
    end
  end

  describe '#NEW' do

    it "should call project's new" do
    	project
      Project.should_receive(:new).and_return(project)
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
			project
		end

    it "should call Project's new" do
      Project.should_receive(:new).with({ 'name' => 'test' }).and_return(project)
      project_create_request
    end

    it 'should call save' do
      Project.stub(:new).and_return(project)
      project.should_receive(:save).and_return(true)
      project_create_request
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
  		get :edit, { id: project.id }
  	end

    it 'should render edit' do
      response.should render_template :edit
    end
  	
  	it "should call Project's edit" do
  		response.code.should eq('200')
  	end
  end

  describe '#UPDATE' do

    context 'when successfully update attributes' do

      it 'should redirect to show page' do
        project_update_request(project.id)
        response.should redirect_to project_path(project)
      end

      it 'should have response code 302' do
        project_update_request(project.id)
        response.code.should eq('302')
      end

      it 'should set flash notice' do
        project_update_request(project.id)
        flash[:notice].should eq("Project test was successfully updated.")
      end
    end

    context 'when not successfully update attributes' do
      before do
        patch :update, { id: project.id, project: { state: Project::STATE.length + 1 } }
      end

      it 'should render edit' do
        response.should render_template :edit
      end

      it 'should have response code 200' do
        response.code.should eq('200')
      end

      it 'should have errors' do
      	project.errors.count > 1
      end
    end
  end

  describe '#SHOW' do
  	before do
  		get :show, { id: Project.id }
  	end

  	it 'should render the show page' do
      response.should render_template :show
  	end

  	it 'should have response code 200' do
  		response.code.should eq('200')
  	end
  end
end

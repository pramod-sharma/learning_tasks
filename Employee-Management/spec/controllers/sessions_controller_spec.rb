require 'spec_helper'

describe SessionsController do

  let(:employee) { FactoryGirl.create(:employee, :admin) }

  def team_create_request
    post :create, { :team => {:name => 'test' } }
  end

  def get_index
    get :index
  end

  def team_update_request(id, name)
    patch :update, { id: id, team: { name: name } }
  end

  def team_delete_request(id)
    delete :destroy, { id: id }  
  end

  describe '#NEW' do
    context 'when user is logged in' do
      before { session[:user_id] = employee.id }

      it 'should redirect  new' do
        get :new
        response.should redirect_to admin_path
      end

      it 'should have response code 302' do
        get :new
        response.code.should eq('302')
      end
    end    

    context 'when user is not logged in' do
      it 'should redirect to new' do
        get :new
        response.should render_template :new
      end

      it 'should have response code 200' do
        get :new
        response.code.should eq('200')
      end
    end
  end

  describe '#DESTROY' do
    before { session[:user_id] = employee.id }

    it 'should receive reset session' do
      controller.should_receive(:reset_session)
      delete :destroy
    end

    it 'should redirect to new' do
      delete :destroy
      response.should redirect_to login_path
    end

    it 'should have response code 302' do
      delete :destroy
      response.code.should eq('302')
    end
  end

	# describe '#CREATE' do
 #    before do
 #      controller.stub(:authenticate_google_account).and_return('')

 #    context "when there is code in params" do
 #      before do
 #        controller.stub(:authenticate_google_account).and_return('')
        
 #    end

 #    before { team }
 #    it "should call Team's new" do
 #      Team.should_receive(:new).with({ 'name' => 'test' }).and_return(team)
 #      team_create_request
 #    end

 #    it 'should call save' do
 #      Team.stub(:new).and_return(team)
 #      team.should_receive(:save)
 #      team_create_request
 #    end

 #    context 'when saved' do
 #      before do
 #        Team.stub(:new).and_return(team)
 #        team.stub(:save).and_return(true)
 #        team_create_request
 #      end

 #      it 'should redirect to show' do
 #        response.should redirect_to teams_path
 #      end

 #      it 'should have response code 302' do
 #        response.code.should eq('302')
 #      end

 #      it 'should set flash notice' do
 #        # team
 #        flash[:notice].should eq("Team #{team.name} created successfully.")
 #      end
 #    end

 #    context 'when not saved' do
 #      before do
 #        Team.stub(:new).and_return(team)
 #        team.stub(:save).and_return(false)
 #        team_create_request
 #      end

 #      it 'should render new' do
 #        response.should render_template :new
 #      end

 #      it 'should have response code 200' do
 #        response.code.should eq('200')
 #      end
 #    end
 #  end
end

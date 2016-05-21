require 'spec_helper'

describe TeamsController do

	describe "POST create" do
		
		let(:team) { mock_model(Team).as_null_object }
		
		before do
			Team.stub(:new).and_return(team)
		end

		it "creates a new team" do
			Team.should_receive(:new).with("name" => "Test Team").and_return(team)
			post :create, 'team' => { 'name' => 'Test Team2' }
		end

		it "saves the team" do
			team.should_receive(:save)
			post :create
		end

		it "redirects to the Teams index" do
			post :create
			response.should redirect_to( login_path )
		end

  # describe "POST create" do
  #   it "creates a new team" do
  #   	team = mock_model( Team ).as_null_object
  #   	# pending('drive out redirect')
  #     Team.should_receive(:new).with("name" => "Test").and_return( team )
  #     post :create, :team => { "name" => "Test"}
  #   end

  #   it "saves the team" do
  #   	team = mock_model( Team ) # team object will acts as an object of Team model even though it is not one
  #   	Team.stub(:new).as_null_object.and_return(team) # Stub will let call new on Team model
  #   	team.should_receive(:save)
  #   	post :create
  #   end

  #   it "redirects to Teams index" do
  #   	post :create
  #   	response.should redirect_to(login_path)
  #   end
  end
end

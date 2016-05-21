require 'spec_helper'

describe Project do
  let(:project) { FactoryGirl.create(:project) }

  let(:employee) { FactoryGirl.create(:employee) }

  before(:each) do
    @project_assignment = ProjectAssignment.find_or_create_by( project_id: project.id, employee_id: employee.id,
      join_from: 1.day.ago, relieving_date: 1.day.from_now )

    @previous_project_assignment = ProjectAssignment.find_or_create_by( project_id: project.id, employee_id: employee.id,
      join_from: 7.days.ago, relieving_date: 2.days.ago )
  end

  # def valid_attributes
  #   { name: "Test", start_date: Date.parse("2013-08-20"), end_date: Date.parse("2013-08-25") }
  # end
  
  # before(:each) do
  #   # @team = Team.find_or_create_by(name: 'Test')
  #   # @employee = Employee.find_or_create_by( name: "Test", email: "test@example.com",
  #   #   designation: Employee::DESIGNATIONS.values.first, potential_revenue: 2000, actual_revenue: 2500,
  #   #   team_id: @team.id )
  #   @project = FactoryGirl.create(:project)
    
  # end

  # def valid_attributes
  #   { name: "Test", email: "test@example.com", designation: Employee::DESIGNATIONS.values.first,
  #     potential_revenue: 2000, actual_revenue: 2500, team_id: @team.id }
  # end

  # it "is valid with valid attributes" do
  #   employee = Employee.find_or_create_by( valid_attributes )
  #   employee.should be_valid
  # end

  describe "Validations" do
    describe 'name' do
      subject { project }

      context 'it is present' do
        it { should be_valid }
      end

      context 'it is not present' do
        before(:each) do
          project.name = nil
        end
        it { should_not be_valid }
      end

      context 'it is duplicate entry' do
          before(:each) do
            @new_project = FactoryGirl.build(:project, name: project.name)
          end
          subject { @new_project }
          it { should_not be_valid }
        end
      end

    describe 'start date' do
      subject { project }

      context 'it is present' do
        it { should be_valid }
      end

      context 'it is not present' do
        before(:each) do
          project.start_date = nil
        end
        it { should_not be_valid }
      end
    end

    describe 'end date' do
      subject { project }

      context 'it is present' do
        context 'when later than start date' do
          it { should be_valid }
        end
        
        context 'it is less than start date' do
          before(:each) do
            project.end_date = project.start_date - 1
          end
          it { should_not be_valid }
        end

        context 'it is earlier than start date' do
          before(:each) do
            project.end_date = project.start_date + 1
          end
          it { should be_valid }
        end
      end

      context 'it is not present' do
        before(:each) do
          project.end_date = nil
        end
        it { should_not be_valid }
      end
    end

    describe 'state' do
      subject { project }

      context 'it is not present' do
        before(:each) do
          project.state = nil
        end
        it { should_not be_valid }
      end

      context 'it is present' do
        context 'it is not in list' do
          before(:each) do
            project.state = Project::STATE.length + 1
          end
          it { should_not be_valid }
        end

        context 'it is in  list' do
          it { should be_valid }
        end
      end
    end
  end

  describe 'Callbacks' do
    describe 'before save' do
      context 'state is changed' do
        context 'and changed states include completed' do
          context 'and state is changed to completed' do
            before(:each) do
              @project = project.update_attributes(state: Project::STATE['Completed'])
            end
            it 'should change active status to false' do
              puts @project.inspect
              expect(@project).should_not be_active
            end

            it 'should change end date' do
              expect(@project.end_date).to eq Date.current
            end
          end

          context 'and state is changed from completed' do
            before(:each) do
              @project = project.update_attributes(state: Project::STATE['Completed'])
              @project.update_attributes(state: Project::STATE['Running'])
            end
            it 'should change active state to true' do
              expect(@project).should be_active
            end

            it 'should nullify end date' do
              expect(@project.end_date).should be_nil
            end
          end
        end

        context 'changed states does not include completed' do
          before(:each) do
            project.update(state: Project::STATE['Potential'])
          end
          it 'should not change active state' do
            expect(project).should be_active
          end
          
          it 'should nullify end date' do
            project
            expect(project.end_date).to eq project.end_date
          end
        end
      end
    end

  end

  describe 'association' do
    describe 'has many project assignments' do
      @association_methods = ['project_assignments', 'project_assignments=', 'project_assignment_ids', 'project_assignment_ids=']
      @association_methods.each do |method|
        it "should respond to #{method}" do
          expect(project.respond_to?(method.to_sym)).to eq true
        end
      end

      @association_methods = ['<<', 'delete', 'destroy', 'clear', 'empty?', 'size', 'find', 'where', 'exists?', 'build', 'create']
      @association_methods.each do |method|
        it "should respond to project_assignments.#{method}" do
          expect(project.project_assignments.respond_to?(method.to_sym)).to eq true
        end
      end
    end

    describe 'has many employees' do
      @association_methods = ['employees', 'employees=', 'employee_ids', 'employee_ids=']
      @association_methods.each do |method|
        it "should respond to #{method}" do
          expect(project.respond_to?(method.to_sym)).to eq true
        end
      end

      @association_methods = ['<<', 'delete', 'destroy', 'clear', 'empty?', 'size', 'find', 'where', 'exists?', 'build', 'create']
      @association_methods.each do |method|
        it "should respond to employees.#{method}" do
          expect(project.employees.respond_to?(method.to_sym)).to eq true
        end
      end
    end

    describe 'has many monthly billings' do
      @association_methods = ['monthly_billings', 'monthly_billings=', 'monthly_billing_ids', 'monthly_billing_ids=']
      @association_methods.each do |method|
        it "should respond to #{method}" do
          expect(project.respond_to?(method.to_sym)).to eq true
        end
      end

      @association_methods = ['<<', 'delete', 'destroy', 'clear', 'empty?', 'size', 'find', 'where', 'exists?', 'build', 'create']
      @association_methods.each do |method|
        it "should respond to employees.#{method}" do
          expect(project.employees.respond_to?(method.to_sym)).to eq true
        end
      end
    end
  end

  describe 'Instance methods' do
    # before(:each) do
    #   @future_project_assignment = ProjectAssignment.find_or_create_by( project_id: project.id, employee_id: employee.id,
    #   join_from: Date.today + 1, relieving_date: Date.today + 1 )
    #   @previous_project_assignment = ProjectAssignment.find_or_create_by( project_id: project.id, employee_id: employee.id,
    #   join_from: Date.today - 1, relieving_date: Date.today - 1 )
    # end


    describe '#current_assignments_on' do
      context 'when there are assignments for current date' do
        it { project.current_assignments_on(Date.current).should include(@project_assignment) }
      end

      context 'when there are no assignments for current date' do
        it { project.current_assignments_on(5.days.from_now).should be_empty }
      end      
    end

    describe '#live_assignments' do
      it 'should return live assignments as on today' do
        expect(project.live_assignments).to include(@project_assignment)
      end
    end

    describe '#previous_assignments' do
      it 'should return previous assignments as on today' do
        expect(project.previous_assignments).to include(@previous_project_assignment)
      end
    end
  end

  describe 'Scopes' do
    describe '.active' do
      context 'there are projects in running state' do
        before(:each) do
          project.update_attributes(state: Project::STATE['Running'])
        end
        it 'should return running projects' do
          expect(Project.active).to include(project)
        end
      end
      context 'there are no running project' do
        before(:each) do
          project.update_attributes(state: Project::STATE['Completed'])
        end
        it 'should return empty Object' do
          expect(Project.active).should be_empty
        end
      end
    end

    describe '.inactive' do
      context 'there are projects in completed state' do
        before(:each) do
          project.update_attributes(state: Project::STATE['Completed'])
        end
        it 'should return completed projects' do
          expect(Project.inactive).to include(project)
        end
      end
      context 'there are no completed project' do
        before(:each) do
          project.update_attributes(state: Project::STATE['Running'])
        end
        it 'should return empty Object' do
          expect(Project.inactive).should be_empty
        end
      end
    end

    describe '.potential' do
      context 'there are projects in potential state' do
        before(:each) do
          project.update_attributes(state: Project::STATE['Potential'])
        end
        it 'should return potential projects' do
          expect(Project.potential).to include(project)
        end
      end
      context 'there are no  project' do
        before(:each) do
          project.update_attributes(state: Project::STATE['Running'])
        end
        it 'should return empty Object' do
          expect(Project.potential).to be_empty
        end
      end
    end

    describe '.confirmed' do
      context 'there are projects in confirmed state' do
        it 'should return completed projects' do
          expect(Project.confirmed).to include(project)
        end
      end
      context 'there are no confirmed project' do
        before(:each) do
          project.update_attributes(state: Project::STATE['Running'])
        end
        it 'should return empty Object' do
          expect(Project.confirmed).to be_empty
        end
      end
    end

    describe '.active_on' do
      context 'there are active projects for given date' do
        # before(:each) do
        #   project.update_attributes(state: Project::STATE['Confirmed'])
        # end
        it 'should return active projects for the date' do
          expect(Project.active_on(project.start_date)).to include(project)
        end
      end
      context 'there are no active project for given date' do
        it 'should return empty Object' do
          expect(Project.active_on(project.end_date + 1)).to be_empty
        end
      end
    end
  end
end
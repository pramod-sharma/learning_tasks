require "spec_helper"

describe ProjectAssignment do
  let(:project_assignment) { FactoryGirl.create(:project_assignment) }

  let(:future_project_assignment) { FactoryGirl.create(:project_assignment,
    project_id: project_assignment.project_id, employee_id: project_assignment.employee_id,
    join_from: 20.days.from_now, relieving_date: 25.days.from_now)
  }

  let(:previous_project_assignment) { FactoryGirl.create(:project_assignment,
    project_id: project_assignment.project_id, employee_id: project_assignment.employee_id,
    join_from: 25.days.ago, relieving_date: 20.days.ago)
  }
  # before(:each) do
  #   @employee = Employee.find_or_create_by(name: 'test', email: 'test@ex.com')
  #   @project = Project.find_or_create_by(name: 'test', start_date: Date.parse("2013-08-20"))
  #   @project_assignment = ProjectAssignment.new( valid_attributes )
  #   @project_assignment.project = @project
  #   @project_assignment.employee = @employee
  # end

  # def valid_attributes
  #   { join_from: Date.parse("25-09-2013"), relieving_date: Date.parse("30-09-2013") }
  # end

  describe 'Validations' do
    # it "is valid with valid attributes" do
    #   @project_assignment.should be_valid
    # end

    describe 'join_from' do
      subject { project_assignment }
      context 'when it is present' do
        it { should be_valid }
      end

      context 'when it is not present' do
        before(:each) { project_assignment.join_from = nil }
        it { should_not be_valid }
      end
    end

    describe 'relieving_date' do

      subject { project_assignment }

      context 'when it is present' do
        it { should be_valid }
      end

      context 'when it is not present' do
        before(:each) { project_assignment.relieving_date = nil }
        it { should_not be_valid }
      end

      context 'when it is earlier than join from date' do
        before(:each) { project_assignment.relieving_date = project_assignment.join_from.yesterday }
        it { should_not be_valid }
      end
    end


    describe 'project' do

      subject { project_assignment }
      context 'when it is present' do
        it { should be_valid }
      end

      context 'when it is not present' do
        before(:each) { project_assignment.project = nil }
        it { should_not be_valid }
      end
    end

    describe 'employee' do

      subject { project_assignment }
      context 'when it is present' do
        it { should be_valid }
      end

      context 'when it is not present' do
        before(:each) { project_assignment.employee = nil }
        it { should_not be_valid }
      end
    end

    describe 'involvement' do
      subject { project_assignment }
      context 'when involvement is not present' do
        before(:each) { project_assignment.involvement = nil }
        it { should be_valid }
      end

      context 'when involvement is non numeric' do
        before(:each) { project_assignment.involvement = '20%' }
        it { should_not be_valid }
      end

      context 'when involvement is negative' do
        before(:each) { project_assignment.involvement = -20 }
        it { should_not be_valid }
      end
      
      context 'when involvement is decimal' do
        before(:each) { project_assignment.involvement = 20.50 }
        it { should_not be_valid }
      end

      context 'when involvement is positive integer' do
        before(:each) { project_assignment.involvement = 20 }
        it { should be_valid }
      end
    end
  end


  describe 'associations' do
    subject { project_assignment }
    
    it { should respond_to(:employee) }

    it 'should belongs to employee' do
      association = ProjectAssignment.reflect_on_association(:employee)
      association.macro.should == :belongs_to
    end
    
    it { should respond_to(:project) }

    it 'should belongs to employee' do
      association = ProjectAssignment.reflect_on_association(:project)
      association.macro.should == :belongs_to
    end

    context 'it has duplicate entries for project and employee association for same dates' do
      before(:each) do
        @new_project_assignment = FactoryGirl.build(:project_assignment,
          project_id: project_assignment.project_id, employee_id: project_assignment.employee_id
        )
      end
      subject { @new_project_assignment }
      it { should_not be_valid }
    end
  end


  describe 'Scopes' do
    describe '.previous or manually relieved project assignments' do
      it 'should return previous project assignments' do
        expect(ProjectAssignment.previous_or_manually_relieved_project_assignments(Date.current)).to include(previous_project_assignment)
      end
    end

    describe '.future project assignments' do
      it 'should return previous project assignments' do
        expect(ProjectAssignment.future_project_assignments(Date.current)).to include(future_project_assignment)
      end
    end
  end


  describe 'Instance Methods' do
    describe '#relieve employee' do
      context 'project assignment has started' do
        it 'should update project assignment' do
          expect(project_assignment.relieve_employee(Date.current, 20).join_from).to eq Date.current
        end
      end

      context 'project assignment has not yet started' do
        it 'should destroy project assignment' do
          expect(future_project_assignment.relieve_employee(Date.current, 20)).should be_frozen
        end
      end
    end

    describe '#update_assignment' do
      # context 'new joining date is greater than current date' do
      #   it 'should add error to project assignment' do
      #     expect(project_assignment.update_assignment(Date.current, 4.days.ago, 35).errors.full_messages)
      #     .to include("Relieving Date can't be lesss than Joining Date")
      #   end
      # end

      # context 'new involvement is less than zero' do
      #   it 'should add error to project assignment' do
      #     expect(project_assignment.update_assignment(Date.current, 15.days.from_now, -35).errors.full_messages)
      #     .to include("Involvement can't be less than 0")
      #   end
      # end
    end

    describe '#no previous assignments' do
      context 'when there are previous assignments' do
        it 'should add error to project assignment' do
          expect(project_assignment.no_previous_assignments?.errors.full_messages)
            .to include("#{ current_assignmments.first.employee.name } is already assigned to #{ current_assignmments.first.project.name } for given interval")
        end
      end
    end
  end
end
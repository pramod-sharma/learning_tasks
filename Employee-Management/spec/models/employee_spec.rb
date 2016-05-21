require 'spec_helper'

describe Employee do
  let(:employee) { FactoryGirl.create(:employee) }
  let(:revenue_projection) { employee.revenue_projections.last}
  
  before(:each) do
    @project = FactoryGirl.create(:project)
    @project_assignment = ProjectAssignment.find_or_create_by( project_id: @project.id, employee_id: employee.id,
      join_from: 1.day.ago, relieving_date: 1.day.from_now )
    @previous_project_assignment = ProjectAssignment.find_or_create_by( project_id: @project.id, employee_id: employee.id,
      join_from: 7.days.ago, relieving_date: 2.days.ago )
  end

  it "is valid with valid attributes" do
    employee.should be_valid
  end

  describe "Validations" do
    describe 'name' do
      subject { employee }

      context 'when it is present' do
        it { should be_valid }
      end

      context 'when it is not present' do
        before(:each) { employee.name = nil }
        it { should_not be_valid }
      end
    end

    describe 'email' do
      subject { employee }

      context 'when it is present' do
        it { should be_valid }
      end

      context 'when it is not present' do
        before(:each) { employee.email = nil }
        it { should_not be_valid }
      end

      context 'when it is of given format' do
        it { should be_valid }
      end

      context 'when it is not of given format' do
        before(:each) { employee.email = 'pramod' }
        it { should_not be_valid }
      end

      context 'when it is duplicate entry' do
        before(:each) { @new_employee = FactoryGirl.build(:employee, email: employee.email) }
        subject { @new_employee }
        it { should_not be_valid }
      end
    end

    describe 'potential revenue' do
      subject { employee }

      context 'when it is not present' do
        before(:each) do { employee.potential_revenue = nil }
        it { should_not be_valid }
      end

      context 'when it is non numeric' do
        before(:each) { employee.potential_revenue = '$4000' }
        it { should_not be_valid }
      end

      context 'when it is negative' do
        before(:each) { employee.potential_revenue = -4000 }
        it { should_not be_valid }
      end
      
      context 'when it is decimal' do
        before(:each) { employee.potential_revenue = 2000.50}
        it { should_not be_valid }
      end

      context 'when it is positive integer' do
        before(:each) { employee.potential_revenue = 2000 }
        it { should be_valid }
      end
    end


    describe 'actual revenue' do
      subject { employee }

      context 'when it is not present' do
        before(:each) { employee.actual_revenue = nil }
        it { should_not be_valid }
      end

      context 'when it is non numeric' do
        before(:each) { employee.actual_revenue = '$4000' }
        it { should_not be_valid }
      end

      context 'when it is negative' do
        before(:each) { employee.actual_revenue = -4000 }
        it { should_not be_valid }
      end

      context 'when it is decimal' do
        before(:each) { employee.actual_revenue = 2000.50 }
        it { should_not be_valid }
      end

      context 'when it is positive integer' do
        it { should be_valid }
      end
    end


    describe 'designation' do
      subject { employee }

      context 'when designation is not present' do
        before(:each) do
          employee.designation = nil
        end
        it { should_not be_valid }
      end

      context 'when designation is not in list' do
        before(:each) do
          employee.designation = Employee::DESIGNATIONS.length + 1
        end
        it { should_not be_valid }
      end

      context 'when designation is in  list' do
        it { should be_valid }
      end
    end
  end

  describe 'Callbacks' do
    describe 'after save' do
      context 'potential revenue changed' do
        before(:each) do
          employee.update(potential_revenue: 5000)
        end
        it 'should change revenue projection potential revenue' do
          expect(employee.revenue_projection_of(Date.current.beginning_of_month).potential_revenue).to eq 5000
        end
      end

      context 'actual revenue changed' do
        before(:each) do
          employee.update_attributes(actual_revenue: 5000)
        end
        it 'should change revenue projection actual revenue' do
          expect(employee.revenue_projection_of(Date.current.beginning_of_month).actual_revenue).to eq 5000
        end
      end
    end
  end

  describe 'association' do
    describe 'has many project assignments' do
      @association_methods = ['project_assignments', 'project_assignments=', 'project_assignment_ids', 'project_assignment_ids=']
      @association_methods.each do |method|
        it "should respond to #{method}" do
          expect(employee.respond_to?(method.to_sym)).to eq true
        end
      end

      @association_methods = ['<<', 'delete', 'destroy', 'clear', 'empty?', 'size', 'find', 'where', 'exists?', 'build', 'create']
      @association_methods.each do |method|
        it "should respond to project_assignments.#{method}" do
          expect(employee.project_assignments.respond_to?(method.to_sym)).to eq true
        end
      end
    end

    describe 'has many projects' do
      @association_methods = ['projects', 'projects=', 'project_ids', 'project_ids=']
      @association_methods.each do |method|
        it "should respond to #{method}" do
          expect(employee.respond_to?(method.to_sym)).to eq true
        end
      end

      @association_methods = ['<<', 'delete', 'destroy', 'clear', 'empty?', 'size', 'find', 'where', 'exists?', 'build', 'create']
      @association_methods.each do |method|
        it "should respond to projects.#{method}" do
          expect(employee.projects.respond_to?(method.to_sym)).to eq true
        end
      end
    end

    describe 'has many subordinates' do
      @association_methods = ['subordinates', 'subordinates=', 'subordinate_ids', 'subordinate_ids=']
      @association_methods.each do |method|
        it "should respond to #{method}" do
          expect(employee.respond_to?(method.to_sym)).to eq true
        end
      end

      @association_methods = ['<<', 'delete', 'destroy', 'clear', 'empty?', 'size', 'find', 'where', 'exists?', 'build', 'create']
      @association_methods.each do |method|
        it "should respond to projects.#{method}" do
          expect(employee.subordinates.respond_to?(method.to_sym)).to eq true
        end
      end
    end

    describe 'has many revenue projections' do
      @association_methods = ['revenue_projections', 'revenue_projections=', 'revenue_projection_ids', 'revenue_projection_ids=']
      @association_methods.each do |method|
        it "should respond to #{method}" do
          expect(employee.respond_to?(method.to_sym)).to eq true
        end
      end

      @association_methods = ['<<', 'delete', 'destroy', 'clear', 'empty?', 'size', 'find', 'where', 'exists?', 'build', 'create']
      @association_methods.each do |method|
        it "should respond to projects.#{method}" do
          expect(employee.revenue_projections.respond_to?(method.to_sym)).to eq true
        end
      end
    end

    describe 'belongs to a team lead' do
      subject { employee }
      it { should respond_to(:team_lead) }
      it 'should belongs to team lead' do
        association = Employee.reflect_on_association(:team_lead)
        association.macro.should == :belongs_to
      end
    end

    describe 'belongs to a team' do
      subject { employee }
      it { should respond_to(:team) }
      it 'should belongs to team' do
        association = Employee.reflect_on_association(:team)
        association.macro.should == :belongs_to
      end
    end
  end

  describe 'Instance methods' do
    # before(:each) do
    #   @future_project_assignment = ProjectAssignment.find_or_create_by( project_id: @project.id, employee_id: @employee.id,
    #   join_from: Date.today + 1, relieving_date: Date.today + 1 )
    #   @previous_project_assignment = ProjectAssignment.find_or_create_by( project_id: @project.id, employee_id: @employee.id,
    #   join_from: Date.today - 1, relieving_date: Date.today - 1 )
    # end


    describe '#current_assignments_on' do
      context 'when there are assignments for current date' do
        it { employee.current_assignments_on(Date.current).should include( @project_assignment ) }
      end

      context 'when there are no assignments for current date' do
        it { employee.current_assignments_on(2.days.ago).should be_empty }
      end      
    end

    describe '#revenue_projection_of' do
      context 'there are revenue proection for the employee' do
        it 'should return revenue projection for that date' do
          expect(employee.revenue_projection_of(Date.current.beginning_of_month)).to eq revenue_projection
        end
      end

      context 'there are no revenue proection for the employee' do
        it 'should return revenue projection for that date' do
          expect(employee.revenue_projection_of(1.month.ago.beginning_of_month)).to eq nil
        end
      end
    end

    describe '#live_assignments' do
      it 'should return live assignments as on today' do
        expect(employee.live_assignments).to include(@project_assignment)
      end
    end

    describe '#previous_assignments' do
      it 'should return previous assignments as on today' do
        expect(employee.previous_assignments).to include(@previous_project_assignment)
      end
    end

    describe '#involvement_as_on' do
      it 'should return involvement as on date' do
        expect(employee.involvement_as_on(Date.current)).to eq employee.live_assignments.sum(:involvement)
      end
    end
  end
end

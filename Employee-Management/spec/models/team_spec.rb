require "spec_helper"

describe Team do
  let(:team) { FactoryGirl.create(:team) }

  describe 'validation' do
    describe 'name' do
      subject { team }
      
      context 'when it is present' do
        it { should be_valid }
      end

      context 'when it is not present' do
        before(:each) do
          team.name = nil
        end
        it { should_not be_valid }
      end

      context 'when it is not unique' do
        before(:each) do
          @new_team = Team.new(name: team.name)
        end
        subject { @new_team }
        it { should_not be_valid}
      end
    end
  end

  describe 'association' do
    before(:each) do
      FactoryGirl.create(:employee, team: team)
    end

    @association_methods = ['employees', 'employees=', 'employee_ids', 'employee_ids=']
    @association_methods.each do |method|
      it "should respond to #{method}" do
        expect(team.respond_to?(method.to_sym)).to eq true
      end
    end

    @association_methods = ['<<', 'delete', 'destroy', 'clear', 'empty?', 'size', 'find', 'where', 'exists?', 'build', 'create']
    @association_methods.each do |method|
      it "should respond to employee.#{method}" do
        expect(team.employees.respond_to?(method.to_sym)).to eq true
      end
    end
  end
end
require 'spec_helper'

describe RevenueProjection do
  let(:employee) { FactoryGirl.create(:employee) }
  let(:revenue_projection) { employee.revenue_projections.first }

  def valid_attributes
    { date: Date.current.beginning_of_month, employee_id: employee.id, actual_revenue: 2500, potential_revenue: 2500 }
  end

  describe "Validations" do
    describe 'date' do
      subject { revenue_projection }
      context 'when it is present' do
        it { should be_valid }
      end

      context 'when it is not present' do
        before(:each) do
          revenue_projection.date = nil
        end
        it { should_not be_valid }
      end

      context 'when it is not unique' do
        before(:each) do
          @new_revenue_projection = RevenueProjection.new(employee: employee, potential_revenue: 2500,
            actual_revenue: 2500, date: Date.current.beginning_of_month)
        end
        subject { @new_revenue_projection }
        it { should_not be_valid}
      end
    end

    describe 'potential revenue' do
      subject { revenue_projection }
      context 'when potential revenue is not present' do
        before(:each) do
          revenue_projection.potential_revenue = nil
        end
        it { should_not be_valid }
      end

      context 'when potential revenue is non numeric' do
        before(:each) do
          revenue_projection.potential_revenue = '$4000'
        end
        it { should_not be_valid }
      end

      context 'when potential revenue is negative' do
        before(:each) do
          revenue_projection.potential_revenue = -4000
        end
        it { should_not be_valid }
      end
      
      context 'when potential revenue is decimal' do
        before(:each) do
          revenue_projection.potential_revenue = 2000.50
        end
        it { should_not be_valid }
      end

      context 'when potential revenue is positive integer' do
        before(:each) do
          revenue_projection.potential_revenue = 2000
        end
        it { should be_valid }
      end
    end

    describe 'actual revenue' do
      subject { revenue_projection }
      context 'when actual revenue is not present' do
        before(:each) do
          revenue_projection.actual_revenue = nil
        end
        it { should_not be_valid }
      end

      context 'when actual revenue is non numeric' do
        before(:each) do
          revenue_projection.actual_revenue = '$4000'
        end
        it { should_not be_valid }
      end

      context 'when actual revenue is negative' do
        before(:each) do
          revenue_projection.actual_revenue = -4000
        end
        it { should_not be_valid }
      end
      
      context 'when actual revenue is decimal' do
        before(:each) do
          revenue_projection.actual_revenue = 2000.50
        end
        it { should_not be_valid }
      end

      context 'when actual revenue is positive integer' do
        before(:each) do
          revenue_projection.actual_revenue = 2000
        end
        it { should be_valid }
      end
    end

    describe 'employee' do
      subject { revenue_projection }
      context 'when employee is associated' do
        it { should be_valid }
      end

      context 'when employee is not associated' do
        before(:each) do
          revenue_projection.employee = nil
        end
        it { should_not be_valid }
      end
    end
  end

  describe 'associations' do
    subject { revenue_projection }
    it { should respond_to(:employee) }
    it 'should belongs to employee' do
      association = RevenueProjection.reflect_on_association(:employee)
      association.macro.should == :belongs_to
    end
  end

  describe 'Scopes' do
    describe '.current_or_latest' do
      it 'should return latest or current revenue projection' do
        revenue_projection
        expect(RevenueProjection.current_or_latest(Date.current.beginning_of_month)).to eq revenue_projection
      end
    end
  end
end

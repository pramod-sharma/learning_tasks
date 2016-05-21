require 'spec_helper'

describe MonthlyBilling do
  let(:monthly_billing) { FactoryGirl.create(:monthly_billing) }

  # def valid_attributes
  #   { billing_date: Date.today.beginning_of_month, project_id: @project.id, amount: 2000 }
  # end

  describe "Validations" do
    describe 'billing date' do
      subject { monthly_billing }

      context 'when it is present' do
        it { should be_valid }
      end

      context 'when it is not present' do
        before(:each) do
          monthly_billing.billing_date = nil
        end
        it { should_not be_valid }
      end

      context 'when it is not unique with respect to project' do
        before(:each) do
          @new_monthly_billing = FactoryGirl.build(:monthly_billing, project_id: monthly_billing.project_id)
          @new_monthly_billing.amount = 3000
        end
        subject { @new_monthly_billing }

        it { should_not be_valid }
      end     
    end

    describe 'amount' do
      subject { monthly_billing }

      context 'when amount is not present' do
        before(:each) do
          monthly_billing.amount = nil
        end
        it { should_not be_valid }
      end

      context 'when amount is non numeric' do
        before(:each) do
          monthly_billing.amount = '$4000'
        end
        it { should_not be_valid }
      end

      context 'when amount is negative' do
        before(:each) do
          monthly_billing.amount = -4000
        end
        it { should_not be_valid }
      end
      
      context 'when amount is decimal' do
        before(:each) do
          monthly_billing.amount = 2000.50
        end
        it { should_not be_valid }
      end

      context 'when amount is positive integer' do
        before(:each) do
          monthly_billing.amount = 2000
        end
        it { should be_valid }
      end
    end

    describe 'project' do
      subject { monthly_billing }

      context 'when project is associated' do
        it { should be_valid }
      end

      context 'when project is not associated' do
        before(:each) do
          monthly_billing.project_id = nil
        end
        it { should_not be_valid }
      end
    end
  end
    
  # it "is valid with valid attributes" do
  #   monthly_billing = MonthlyBilling.find_or_create_by( valid_attributes )
  #   monthly_billing.should be_valid
  # end

  describe 'associations' do
    subject { monthly_billing }

    it { should respond_to(:project) }

    it 'should belongs to project' do
      association = MonthlyBilling.reflect_on_association(:project)
      association.macro.should == :belongs_to
    end
  end

  describe 'Scope' do
    describe '.uncompleted projects billing' do
      it 'should return all uncompleted projects billing' do
        monthly_billing
        expect( MonthlyBilling.uncompleted_projects_billing.first ).to eq monthly_billing
      end
    end

    describe '.non potential projects' do
      it 'should return all non potential projects billing for given date' do
        monthly_billing
        expect( MonthlyBilling.non_potential_projects(Date.current.beginning_of_month).first )
        .to eq monthly_billing
      end
    end

    describe '.of' do
      it 'should return all projects billings of given date' do
        monthly_billing
        expect( MonthlyBilling.of(Date.current.beginning_of_month).first ).to eq monthly_billing
      end
    end
  end
end

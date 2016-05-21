class RevenueProjection < ActiveRecord::Base
	validates :employee_id, :date, :actual_revenue, :potential_revenue, presence: true
	validates :potential_revenue, :actual_revenue, numericality: { greater_than_or_equal_to: 0,
    only_integer: true }, allow_blank: true
	validates :date, uniqueness: { scope: :employee_id }, allow_blank: true
  belongs_to :employee
  #FIXME_AB: following scope should be named as :for since projection itself in the model name. So that we can call: RevenueProjection.for(:month, :year)
  #FIXME_AB: instad of passing month and year in following block. Should be passing date object. RevenueProjection.for(:date)
  #FIXME_NISH: We can pass default parameter to scope and then assign an appt. name for this scope.
  #Fixed 
  scope :current_or_latest, lambda { |date| where("date <= :date", date: date).order( "date DESC" ).first }
end
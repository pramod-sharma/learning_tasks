class ModifyDateFieldsInMonthlyBilling < ActiveRecord::Migration
  def up
    add_column :monthly_billings, :billing_date, :date

    MonthlyBilling.all.each do |bill|
      bill.billing_date = Date.parse( "#{ bill.month } #{ bill.year }" ).beginning_of_month if(  bill.month && bill.year ) 
      bill.save
    end
    remove_columns :monthly_billings, :month, :year
  end

   def down
    add_column :monthly_billings, :month, :string
    add_column :monthly_billings, :year, :integer

    MonthlyBilling.all.each do |bill|
      if bill.billing_date
        bill.month = bill.billing_date.strftime( "%B" )
        bill.year = bill.billing_date.strftime( "%Y" )
      end
      bill.save
    end

    remove_column :monthly_billings, :billing_date
  end
end

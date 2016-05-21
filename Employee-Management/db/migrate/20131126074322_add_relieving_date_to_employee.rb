class AddRelievingDateToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :relieving_date, :date
  end
end

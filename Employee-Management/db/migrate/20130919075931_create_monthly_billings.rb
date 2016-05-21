class CreateMonthlyBillings < ActiveRecord::Migration
  def change
    create_table :monthly_billings do |t|
      t.string :month
      t.integer :year
      t.integer :amount
      t.references :project, index: true

      t.timestamps
    end
  end
end

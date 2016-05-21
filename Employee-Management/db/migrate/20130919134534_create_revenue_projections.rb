class CreateRevenueProjections < ActiveRecord::Migration
  def change
    create_table :revenue_projections do |t|
      t.integer :actual_revenue
      t.integer :potential_revenue
      t.integer :month
      t.integer :year
      t.references :employee, index: true

      t.timestamps
    end
  end
end

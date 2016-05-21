class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      #FIXME_AB: t.string :name, :email, :designation
      t.string :name
      t.string :email
      t.string :designation
      t.integer :potential_revenue
      t.integer :actual_revenue
      t.string :team

      t.timestamps
    end
  end
end

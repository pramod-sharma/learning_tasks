class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      #FIXME_AB: name should not accept null so use - :null => false
      # Comment:- Should I create a new migration for this
      t.string :name
      #FIXME_AB: Another way to do this is t.date :start_date, :end_date
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end

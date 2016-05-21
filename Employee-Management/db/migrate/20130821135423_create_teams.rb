class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      #FIXME_AB: name should not accept null so use - :null => false
      t.string :name

      t.timestamps
    end
  end
end

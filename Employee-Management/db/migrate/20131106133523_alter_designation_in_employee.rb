class AlterDesignationInEmployee < ActiveRecord::Migration
  def up
  	Rake::Task['alter_designations'].invoke #is it okay to invoke the necessary rake task here
  	change_column( :employees, :designation, :integer, :limit => 1 )
  end

  def down
  	change_column( :employees, :designation, :string )
  end
end

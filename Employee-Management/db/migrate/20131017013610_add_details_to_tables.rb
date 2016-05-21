class AddDetailsToTables < ActiveRecord::Migration
  def change
  	remove_column :projects, :closed
  	add_column :projects, :active, :boolean, default: true
  	 
  	add_column :employees, :active, :boolean, default: true
  end
end
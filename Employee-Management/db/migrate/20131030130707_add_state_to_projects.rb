class AddStateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :state, :integer, limit: 1
  end
end
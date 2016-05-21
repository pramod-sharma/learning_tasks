class ChangeDefaultValueOfTableColumns < ActiveRecord::Migration
  def up
    change_column_default(:employees, :potential_revenue, 0)
    change_column_default(:employees, :actual_revenue, 0)
    change_column_default(:project_assignments, :involvement, 0)
    change_column_default(:revenue_projections, :potential_revenue, 0)
    change_column_default(:revenue_projections, :actual_revenue, 0)


    Employee.reset_column_information
    Employee.all.each do |employee|
      employee.update_columns( :potential_revenue => ( employee.potential_revenue || 0 ) ,
        :actual_revenue => ( employee.actual_revenue || 0 ) )
    end

    ProjectAssignment.reset_column_information
    ProjectAssignment.all.each do |assignment|
      assignment.update_attribute( 'involvement', ( assignment.involvement || 0 ) )
    end

    RevenueProjection.reset_column_information
    RevenueProjection.all.each do |revenue_projection|
      revenue_projection.update_columns( :potential_revenue => ( revenue_projection.potential_revenue || 0 ) ,
        :actual_revenue => ( revenue_projection.actual_revenue || 0 ) )
    end

  end
  def down
    change_column_default(:employees, :potential_revenue, nil)
    change_column_default(:employees, :actual_revenue, nil)
    change_column_default(:project_assignments, :involvement, nil)
    change_column_default(:revenue_projections, :potential_revenue, nil)
    change_column_default(:revenue_projections, :actual_revenue, nil)
  end

end

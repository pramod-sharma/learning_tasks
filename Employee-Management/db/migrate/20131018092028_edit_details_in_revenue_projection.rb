class EditDetailsInRevenueProjection < ActiveRecord::Migration
  def up
    add_column :revenue_projections, :date, :date

    RevenueProjection.all.each do | projection |
      projection.date = Date.parse( "01 #{ projection.month } #{ projection.year }" ) if(  projection.month && projection.year ) 
      projection.save
    end
    remove_columns :revenue_projections, :month, :year
  end

   def down
    add_column :revenue_projections, :month, :string
    add_column :revenue_projections, :year, :integer

    RevenueProjection.all.each do | projection |
      if projection.date
        projection.month = projection.date.strftime( "%B" )
        projection.year = projection.date.strftime( "%Y" )
      end
      projection.save
    end

    remove_column :revenue_projections, :date
  end
end

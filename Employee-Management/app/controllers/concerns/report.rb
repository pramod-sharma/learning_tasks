
module Report

  #FIXME_AB: Why this constant hash is defined again. You have this in application.rb also. Also we we need this. 
  # Fixed
  
  #FIXME_AB: Lets discuss this I see logical/algo issues here
  def prepare_revenue_projection_gon( projection_beginning_date, projection_ending_date )
    gon.revenue_projections = []
    #gon.revenue_projections << ['Month', nil, nil , nil, nil]
    previous_projection = 0
    date_array = (projection_beginning_date..projection_ending_date).select{|date| date.day == 1}

    date_array.each do | projection_date |

      monthly_potential_revenue, monthly_actual_revenue = 0, 0
      monthly_potential_revenue = Employee.active_on(projection_date).to_a.sum do |employee|
        employee.revenue_projections.current_or_latest( projection_date ).try( :potential_revenue ) || 0
      end

      monthly_actual_revenue = MonthlyBilling.where("billing_date = ?", projection_date).joins(:project).
        where( "projects.state != ? OR ( projects.state != ? AND projects.end_date <= ? ) ",
          Project::STATE['Potential'], Project::STATE['Completed'], projection_date ).sum( :amount )

      gon.revenue_projections << [ projection_date.to_s(:string_month), monthly_potential_revenue, "$#{monthly_potential_revenue}",  monthly_actual_revenue, "$#{monthly_actual_revenue}"]
    end
    return gon.revenue_projections
  end




  #FIXME_AB: Lets discuss this I see logical/algo issues here
  def prepare_team_gon(utilization_date)
    gon.data, gon.titles, gon.ids, gon.links = [], [], [], []
    Team.all.each do |team|
      if team.employees.any?
        team_involvement = team.employees.sum do |emp|
          emp.involvement_as_on(utilization_date)
        end
        max_involvement = team.employees.count * 100
        actual_team_involvement = team_involvement * 100 / max_involvement
        team_involvement = actual_team_involvement > 100 ? 100 : actual_team_involvement
        team_availability = 100 - team_involvement
        gon.titles << team.name
        gon.data << [
          ['Involved', team_involvement],
          ['Available', team_availability]
        ]
        gon.ids << team.id
        gon.links << view_context.link_to(team.name, team_path(team) )
      end
    end
    return {'ids' => gon.ids, 'data' => gon.data, 'titles' => gon.titles, 'links' => gon.links }
  end

  #FIXME_AB: Always use brackets "()" when you pass arguments or receive them
  # Fixed
  #FIXME_AB: Is this the right way to do this. Can't we avoid nested if statements
  # Moved functionality to scope

  #FIXME_AB: Lets discuss this I see logical/algo issues here




  def prepare_piechart_json(utilization_date, record, key)
    titles, ids, data, links = [], [], [], []
    involved, total = 0, 0
    if key == 'team'
      # employees = Employee.where(team_id: id)
        # FIXME_AB: avoid using unless statements unless you really need it, as discussed
        # Fixed
      record.team_leads.active_on(utilization_date).each do |team_lead| 
        #FIXME_AB: avoid using unless statements unless you really need it, as discussed
        titles << team_lead.name
        total, involved = find_involvement( team_lead, utilization_date )
        data = push_data( data, total, involved )
        ids <<  team_lead.id 
        links << view_context.link_to(team_lead.name, employee_path(team_lead) )
      end
    elsif key == 'emp'
      record.subordinates.active_on(utilization_date).each do |employee|
        titles << employee.name
        total, involved = find_involvement(employee, utilization_date)
        data = push_data(data, total, involved)
        ids <<  employee.id
        links << view_context.link_to(employee.name, employee_path(employee))
      end
    end
    pie_report_hash = {'ids' => ids, 'data' => data, 'titles' => titles, 'links' => links}
    return pie_report_hash
  end


  def find_involvement(employee, utilization_date)
    involvement, total = 0, 0
    if employee.subordinates.any?
      subordinates = employee.subordinates
      subordinates.each do |subordinate|
        subordinates_total, subordinates_involvement = find_involvement( subordinate, utilization_date )
        involvement += subordinates_involvement
        total += subordinates_total
      end
    end
    total += 100
    employee_actual_involvement = employee.involvement_as_on(utilization_date)
    involvement += ( employee_actual_involvement > 100 ? 100 : employee_actual_involvement )
    return total, involvement
  end


  def push_data(data, total, involved)
    actual_involvement = involved * 100 / total
    involved = actual_involvement > 100 ? 100 : actual_involvement
    available = 100 - involved
    data << [
        ['Involved', involved],
        ['Available', available]
      ]
  end

end

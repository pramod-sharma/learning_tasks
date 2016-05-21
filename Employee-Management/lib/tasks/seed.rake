#FIXME_AB: There are many issues with these tasks. Lets discuss. One thing is it should accept arguments at run time.
# It should just ask for the email, and rest it should do it by itself.

namespace :seed do
  task :team,[:team_name] do |task, args|
    team = Team.new
    puts "Enter team Name" 
    team.name = STDIN.gets.chomp
    team.save
    team.errors.full_messages.each{ |message| puts message }
  end

  task :employee do |task, args|
    emp = Employee.new
    puts "Enter employee name"
    emp.name = STDIN.gets.chomp
    puts "Enter employee email"
    emp.email = STDIN.gets.chomp
    puts "Whether employee an admin or not?(true/false)"
    emp.is_admin = STDIN.gets.chomp
    puts "Enter employee designation among these:- #{ Employee::DESIGNATIONS.invert() }"
    emp.designation = STDIN.gets.chomp
    puts "Enter employee potential revenue"
    emp.potential_revenue = STDIN.gets.chomp
    puts "Enter employee actual revenue"
    emp.actual_revenue = STDIN.gets.chomp
    emp.team = Team.last
    emp.save
    emp.errors.full_messages.each{ |message| puts message }
  end

  task :data => [:environment ] do |task, args|
    Rake::Task['seed:team'].invoke
    Rake::Task['seed:employee'].invoke
  end
end
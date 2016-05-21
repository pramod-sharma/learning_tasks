namespace :backup do
  task :utilization do
    %x{ bundle exec backup perform -t utilization_weekly_backup }
  end
end
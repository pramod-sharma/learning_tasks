every :tuesday, at: '5pm' do
  command "bundle exec rake backup:utilization"
end

every :friday, at: '5pm' do
  command "bundle exec rake backup:utilization"
end
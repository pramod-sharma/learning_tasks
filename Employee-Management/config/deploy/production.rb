set :application, "utilization.domain4now.com"
set :rails_env, "production"
set :deploy_to ,"/var/www/#{application}"
set :keep_releases, 5
set :user, 'deploy'
set :use_sudo, false
set :branch, "master"

# FIXME_KD: below code can be written as:
# set :domain, '176.58.108.178'
# server domain, :app, :web, :db, :primary => true
role :web, "176.58.108.178"                          # Your HTTP server, Apache/etc
role :app, "176.58.108.178"                          # This may be the same as your `Web` server
role :db,  "176.58.108.178", :primary => true # This is where Rails migrations will run
require "bundler/capistrano"
# for multiple enviroments
require 'capistrano/ext/multistage'
require 'whenever/capistrano'

set :repository,  "git@github.com:pramod-sharma/Employee-Management.git"
set :stages, %w(production staging)
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

default_run_options[:pty] = true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Deploy with migrations"
  task :long do
    transaction do
      update_code
      web.disable
      create_symlink
      migrate
    end

    restart
    web.enable
    cleanup
  end

  
  task :after_symlink, :roles => :app do
    run "ln -s #{ shared_path }/database.yml #{current_path}/config/database.yml"
  end

  desc "Run cleanup after long_deploy"
  task :after_deploy do
    cleanup
    Rake::Task['deploy:update_crontab'].invoke
  end

  task :precompile_assets do
    run "cd #{current_path} ; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
  end

  desc "Update the crontab file"  
  task :update_crontab, :roles => :app do  
    run "cd #{release_path} && whenever --update-crontab #{application}"  
  end

end

task :tail_log, :roles => :app do 
  sudo "tail -f #{shared_path}/log/#{rails_env}.log" 
end 

after "deploy:create_symlink", "deploy:after_symlink"
after "deploy:after_symlink", "deploy:precompile_assets"
require './config/boot'
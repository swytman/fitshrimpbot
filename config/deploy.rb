# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'fitshrimpbot'
set :repo_url, 'git@github.com:swytman/fitshrimpbot.git'
set :branch, "master"
set :deploy_to, '/var/www/fitshrimpbot'
set :linked_files, %w{config/app.yml}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    # invoke 'npm:install'
    invoke 'pm2:restart'
  end

  after :publishing, :restart
end
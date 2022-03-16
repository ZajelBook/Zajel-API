# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "zajel"
set :repo_url, "git@github.com:Bernovia/Zajel-API.git"

set :deploy_to, '/home/ubuntu/apps/zajel'

append :linked_files, "config/master.key", ".env"
# append :linked_files, ".env.production"
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads storage}

set :keep_releases, 2
set :puma_user, fetch(:user)
set :puma_threads, [5, 5]
set :puma_workers, 1
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"    #accept array for multi-bind
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
#set :linked_files, %w{config/database.yml config/secrets.yml}
#set :rvm_type, :deployer
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_role, :app
set :puma_preload_app, false
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_restart_command, 'bundle exec puma'
set :puma_service_unit_name, "zajel-puma"
set :puma_systemctl_user, :user # accepts :user

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

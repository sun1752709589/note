require 'pry'

# lock '3.5.0'

set :application, 'rails5'
set :repo_url, 'git@git.huantengsmart.com:sunyafei/rails5.git'
set :branch, 'master'
set :deploy_to, '/home/deployer/projects/rails5'
set :linked_files, %w{config/sidekiq.yml config/database.yml config/secrets.yml config/cable.yml config/puma.rb config/settings.yml config/schedule.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle}
set :rails_env, 'production'
set :rvm_ruby_version, '2.3.1'

namespace :test do
  desc "test"
  task :test_cap do
    on roles(:all), in: :parallel do |host|
      uptime = capture(:uptime)
      puts "#{host.hostname} reports: #{uptime}"
    end
  end
end

namespace :onm do
  desc "notify to me"
  task :notify do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "notify:email_and_jpush"
        end
      end
    end
  end

  desc "Update Repo"
  task :fetch_repo do
    on roles(:all) do |host|
      within repo_path do
        execute "cd #{repo_path};git fetch origin master:master;cd -"
      end
    end
  end

  %w(start stop restart).each do |action|
    desc "#{action} application"
    task action.to_sym do
      invoke "onm:#{action}_rails"
    end
  end

  desc 'Start rails'
  task :start_rails do
    on roles(:app), in: :sequence do
      within release_path do
        execute :bundle, "exec puma --config #{shared_path}/config/puma.rb"
      end
    end
  end

  desc 'Stop rails'
  task :stop_rails do
    on roles(:app), in: :sequence do
      execute :kill, "-INT `cat #{shared_path}/tmp/pids/puma.pid`"
    end
  end

  desc 'Restart rails'
  task :restart_rails do
    on roles(:app), in: :sequence do
      execute :kill, "-USR1 `cat #{shared_path}/tmp/pids/puma.pid`"
    end
  end

  desc 'Start sidekiq'
  task :start_sidekiq do
    on roles(:app), in: :sequence do
      within release_path do
        execute :bundle, "exec sidekiq -d -e production -L #{shared_path}/log/sidekiq.log -p #{shared_path}/tmp/pids/sidekiq.pid -C #{shared_path}/config/sidekiq.yml"
      end
    end
  end

  desc 'Stop sidekiq'
  task :stop_sidekiq do
    on roles(:app), in: :sequence do
      execute :kill, "-INT `cat #{shared_path}/tmp/pids/sidekiq.pid`"
    end
  end

  desc 'Restart sidekiq'
  task :restart_sidekiq do
    on roles(:app), in: :sequence do
      invoke "onm:stop_sidekiq"
      invoke "onm:start_sidekiq"
    end
  end
end

namespace :deploy do
  desc "restart rails"
  after 'deploy:publishing', 'onm:restart_rails'
  desc "restart sidekiq"
  after 'deploy:publishing', 'onm:restart_sidekiq'
  desc "notify to me"
  after 'deploy:publishing', 'onm:notify'
end

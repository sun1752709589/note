lock '3.5.0'

set :application, 'phantom-report'

namespace :test do
  desc "test"
  task :test_cap do
    on roles(:all), in: :parallel do |host|
      uptime = capture(:uptime)
      puts "#{host.hostname} reports: #{uptime}"
    end
  end
  desc "test_docker"
  task :test_docker do
    on_container_roles :report do |container, host|
      container.execute "ps aux"
    end
  end
end
namespace :app do
  desc "phantom-report git pull"
  task :deploy do
    on roles(:all) do
      execute "cd /home/projects/phantom-report/;git checkout db/schema.rb;git pull;cd -"
    end
  end
end
namespace :rails do
  desc "phantom-report git pull"
  task :pull do
    on roles(:all) do
      execute "cd /home/projects/phantom-report/;git checkout db/schema.rb;git pull;cd -"
    end
  end
  desc "deploy"
  task :deploy do
    invoke "rails:pull"
    on_container_roles :report do |container, host|
      # container.execute "cd /projects/phantom-report/;bundle install;bundle exec rails db:migrate;kill -9 `cat tmp/pids/server.pid`;rails s -b0.0.0.0 -p3000 -d"
      container.execute "cd /projects/phantom-report/;bundle install;kill -9 `cat tmp/pids/server.pid`;bundle exec puma -e development -p 3000 --pidfile tmp/pids/server.pid -d"
    end
  end
  desc "Tail rails logs from server"
  task :tail_dev_log do
    on roles(:app) do
      execute "tail -f /home/projects/phantom-report/log/development.log"
    end
  end
end

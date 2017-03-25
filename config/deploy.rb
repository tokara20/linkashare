set :application, "linkashare"
set :repo_url, "git@github.com:tokara20/linkashare.git"

set :deploy_to, '/home/deploy/linkashare'

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

set :rails_env, fetch(:stage)

namespace :deploy do
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
end

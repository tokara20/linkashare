set :application, "linkashare"
set :repo_url, "git@github.com:tokara20/linkashare.git"

set :deploy_to, '/home/deploy/linkashare'

append :linked_files, "config/database.yml", "config/secrets.yml", "config/cloudinary.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

namespace :deploy do
  desc 'Runs rake db:seed'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end
end



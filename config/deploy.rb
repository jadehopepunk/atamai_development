require "bundler/capistrano"

set :application, "atamai_development"
set :repository,  "https://github.com/craigambrose/atamai_development.git"

set :scm, :git
set :rails_env, "production"
set :deploy_to, "/home/rails/#{application}/production"
set :user, 'rails'
set :use_sudo, false
set :rake, 'bundle exec rake'
set :deploy_via, :remote_cache

set :domain, "atamai.org.nz"
role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

def link_from_shared_to_current(path, dest_path = path)
  src_path = "#{shared_path}/#{path}"
  dst_path = "#{release_path}/#{dest_path}"
  run "for f in `ls #{src_path}/` ; do ln -nsf #{src_path}/$f #{dst_path}/$f ; done"
end

after "deploy:finalize_update" do
  link_from_shared_to_current('config')
end

# namespace :dragonfly do
#   desc "Symlink the Rack::Cache files"
#   task :symlink, :roles => [:app] do
#     run "mkdir -p #{shared_path}/tmp/dragonfly && ln -nfs #{shared_path}/tmp/dragonfly #{release_path}/tmp/dragonfly"
#   end
# end
# after 'deploy:update_code', 'dragonfly:symlink'
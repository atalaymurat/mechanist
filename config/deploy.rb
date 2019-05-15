# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"
user = 'deploy'
domain = '314machine.com'

set :application, "314machine"
set :repo_url, "git@github.com:atalaymurat/mechanist.git"

set :rvm_type, :user
set :rvm_ruby_string, 'ruby-2.6.1/'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/314machine"

role :app, domain
role :web, domain
role :db, domain

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
# append :linked_files, "config/master.key"
set :linked_files, fetch(:linked_files, []).push("config/master.key")
set :linked_files, fetch(:linked_files, []).push("config/database.yml")
# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, { rvm_bin_path: '~/.rvm/bin' }
# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }
set :local_user, :user
# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manualy verifying the host key before first deploy.
set :ssh_options, verify_host_key: :secure

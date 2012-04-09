# QA Server
set :rails_env, "qa"
set :ip_server, "172.16.0.124"
set :environment, "qa"

role :app,     "#{ip_server}"
role :db,      "#{ip_server}", :primary => true
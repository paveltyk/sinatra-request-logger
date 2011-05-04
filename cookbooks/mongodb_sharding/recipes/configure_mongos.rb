user = @node[:users].first
mongo_log = "/data/mongodb/log"

mongo_config_servers = @node[:mongo_utility_instances].select { |instance| instance[:name].match(/config/) }
mongo_config_servers_arg = mongo_config_servers.map { |s| [s[:hostname],27019].join(':') }

mongos_options = {:exec => "#{@node[:mongo_path]}/bin/mongos",
                  :log_path => mongo_log,
                  :user => user[:username],
                  :pid_path => "/var/run/mongodb",
                  :configdb => mongo_config_servers_arg.join(',')}

directory mongo_log do
  owner user[:username]
  group user[:username]
  mode '0755'
  action :create
  recursive true
end

directory '/var/run/mongodb' do
  owner user[:username]
  group user[:username]
  mode '0755'
  action :create
  recursive true
end

template "/etc/conf.d/mongos" do
  source "mongos.conf.erb"
  owner "root"
  group "root"
  mode 0755
  variables({
    :mongos_options => mongos_options
  })
  backup false
end

remote_file "/etc/init.d/mongos" do
  source "mongos.init"
  owner "root"
  group "root"
  mode 0755
  backup false
  action :create
end


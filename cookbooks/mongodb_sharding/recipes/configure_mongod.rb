user = @node[:users].first
mongo_data = "/data/mongodb/data"
mongo_log = "/data/mongodb/log"

mongodb_options = {:exec => "#{@node[:mongo_path]}/bin/mongod",
                   :data_path => mongo_data,
                   :log_path => mongo_log,
                   :user => user[:username],
                   :pid_path => "/var/run/mongodb",
                   :extra_opts => [] }

mongodb_options[:extra_opts] << "--shardsvr" if @node[:name].match(/shard/)
mongodb_options[:extra_opts] << "--configsvr" if @node[:name].match(/config/)

directory mongo_data do
  owner user[:username]
  group user[:username]
  mode  '0755'
  action :create
  recursive true
end

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

template "/etc/conf.d/mongodb" do
  source "mongod.conf.erb"
  owner "root"
  group "root"
  mode 0755
  variables({
    :mongodb_options => mongodb_options
  })
  backup false
end

remote_file "/etc/init.d/mongodb" do
  source "mongod.init"
  owner "root"
  group "root"
  mode 0755
  backup false
  action :create
end


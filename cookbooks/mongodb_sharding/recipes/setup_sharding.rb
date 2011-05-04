user = @node[:users].first
mongo_shards = @node[:mongo_utility_instances].select { |instance| instance[:name].match(/shard/) }
mongo_config_servers = @node[:mongo_utility_instances].select { |instance| instance[:name].match(/config/) }
setup_js = "/data/mongodb/setup_sharding.js"
setup_custom_js = "/data/mongodb/setup_sharding_custom.js"

template setup_js do
  source "setup_sharding.js.erb"
  owner user[:username]
  group user[:username]
  mode '0755'
  backup false
  variables({:mongo_shards => mongo_shards})
end

mongo_shards.each do |instance|
  execute "wait for mongo shard server on #{instance[:name]} to come up" do
    command "until echo 'exit' | #{@node[:mongo_path]}/bin/mongo #{instance[:hostname]}:27018/local --quiet; do sleep 10s; done"
  end
end

mongo_config_servers.each do |instance|
  execute "wait for mongo config server on #{instance[:name]} to come up" do
    command "until echo 'exit' | #{@node[:mongo_path]}/bin/mongo #{instance[:hostname]}:27019/local --quiet; do sleep 10s; done"
  end
end

execute "setup sharding on #{@node[:name] || @node[:instance_role]}" do
  command "#{@node[:mongo_path]}/bin/mongo admin #{setup_js}"
  #only_if "echo 'rs.status()' | #{@node[:mongo_path]}/bin/mongo local --quiet | grep -q 'run rs.initiate'"
end

template setup_custom_js do
  source "setup_sharding_custom.js.erb"
  owner user[:username]
  group user[:username]
  mode '0755'
  backup false
end

execute "customizing sharding on #{@node[:name] || @node[:instance_role]}" do
  command "#{@node[:mongo_path]}/bin/mongo admin #{setup_custom_js}"
end


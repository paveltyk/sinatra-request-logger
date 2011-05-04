#
# Cookbook Name:: mongodb_sharding
# Recipe:: default
#

if @node[:instance_role] == 'util' && @node[:name].match(/mongodb/)
  require_recipe "mongodb_sharding::install"
  require_recipe "mongodb_sharding::configure_mongod"
  require_recipe "mongodb_sharding::start_mongod"
end

if ['app_master','app','solo'].include? @node[:instance_role]
  require_recipe "mongodb_sharding::install"
  require_recipe "mongodb_sharding::configure_mongos"
  require_recipe "mongodb_sharding::start_mongos"
  require_recipe "mongodb_sharding::setup_sharding"
end


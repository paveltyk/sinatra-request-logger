execute "enable mongos" do
  command "rc-update add mongos default"
  action :run
end

execute "start mongos" do
  command "/etc/init.d/mongos restart"
  action :run
end


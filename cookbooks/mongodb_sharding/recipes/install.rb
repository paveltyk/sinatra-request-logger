download_url = "http://fastdl.mongodb.org/linux/#{@node[:mongo_package_name]}.tgz"

execute "fetch #{download_url}" do
  cwd "/tmp"
  command "wget #{download_url}"
  not_if { FileTest.exists?("/tmp/#{@node[:mongo_package_name]}.tgz") }
end

execute "untar /tmp/#{@node[:mongo_package_name]}.tgz" do
  command "cd /tmp; tar zxf #{@node[:mongo_package_name]}.tgz -C /opt"
  not_if { FileTest.directory?("/opt/#{@node[:mongo_package_name]}") }
end


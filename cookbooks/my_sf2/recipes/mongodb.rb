#
# Author:: Alix Chaysinh (<alix.chaysinh@my_sf2.fr>)
# Cookbook Name:: my_sf2
# Recipe:: mongodb

package "unzip" do
  action :install
end

mongo_user = node['my_sf2']['mongodb']['user']
mongo_pass = node['my_sf2']['mongodb']['pass']

file "/var/lib/mongodb/mongod.lock" do
  action :delete
  only_if { ::File.exists?("/var/lib/mongodb/mongod.lock")}
  notifies :restart, "service[mongodb]"
end

execute "create-mongodb-admin-user" do
  command "/usr/bin/mongo admin --eval 'db.addUser(\"#{mongo_user}\", \"#{mongo_pass}\")'"
  action :run
  not_if "/usr/bin/mongo admin --eval 'db.auth(\"#{mongo_user}\", \"#{mongo_pass}\")' | grep -q ^1$"
end

execute "get-rockmongo" do
  command "wget -q http://rockmongo.com/downloads/go?id=12 -O /var/www/rockmongo.zip"
  action :run
  not_if { ::File.exists?("/var/www/rockmongo.zip")}
  action :run
end

execute "unzip-rockmongo" do
  command "cd /var/www; unzip rockmongo.zip"
  action :run
  not_if { ::Dir.exists?("/var/www/rockmongo")}
end

template "/var/www/rockmongo/config.php" do
  action :create
  source "rockmongo.config.php.erb"
  mode 00644
end

rockmongo_url = node['my_sf2']['mongodb']['rockmongo_server_name']
rockmongo_aliases = node['my_sf2']['mongodb']['rockmongo_server_aliases']

web_app "rockmongo" do
  server_name rockmongo_url
  server_aliases rockmongo_aliases
  docroot "/var/www/rockmongo"
end
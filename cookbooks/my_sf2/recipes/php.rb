#
# Author:: Alix Chaysinh (<alix.chaysinh@my_sf2.fr>)
# Cookbook Name:: my_sf2
# Recipe:: php

include_recipe "php"

# Override standard php.ini

begin
  t = resources(:template => "#{node['php']['conf_dir']}/php.ini")
  t.cookbook "my_sf2"
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template #{node['php']['conf_dir']}/php.ini to modify"
end

template "/etc/php5/apache2/php.ini" do
  action :create
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(:directives => node['php']['directives'])
end

package "php5-imap" do
  action :install
end

package "php5-mcrypt" do
  action :install
end

package "php5-xdebug" do
  action :install
end

template "/etc/php5/mods-available/xdebug.ini" do
  action :create
  source "xdebug.ini.erb"
  owner "root"
  mode 00644
end

package "php5-intl" do
  action :install
end

# Workaround for php mongo

execute "install-php-mongo" do
  command "pecl install mongo"
  action :run
  not_if "pecl list | grep mongo"
end

template "/etc/php5/mods-available/mongo.ini" do
  action :create_if_missing
  source "mongo.ini.erb"
  owner "root"
  mode 00644
end

link "/etc/php5/conf.d/20-mongo.ini" do
  to "/etc/php5/mods-available/mongo.ini"
  not_if { ::File.exists?("/etc/php5/conf.d/20-mongo.ini")}
  notifies :restart, "service[apache2]"
end

#php_pear "mongo" do
#  action :install
#end
#
# Author:: Alix Chaysinh (<alix.chaysinh@my_sf2.fr>)
# Cookbook Name:: my_sf2
# Recipe:: symfony2

include_recipe "apache2"

# Composer install

directory "/vagrant/bin" do
  owner "vagrant"
  group "vagrant"
  mode 00775
  action :create
  not_if { ::Dir.exists?("/vagrant/bin")}
end

execute "get-composer" do
  command "curl -sS https://getcomposer.org/installer | php -- --install-dir=bin"
  cwd "/vagrant"
  action :run
  not_if { ::File.exists?("/vagrant/bin/composer.phar")}
end

execute "composer install" do
  cwd "/vagrant"
  command "bin/composer.phar install"
  action :run
  user "vagrant"
  timeout 2400
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  not_if { ::File.exists?("/vagrant/composer.lock")}
end

# Symfony

directory "/vagrant/app/cache" do
  owner "vagrant"
  group "vagrant"
  mode 00777
  action :create
  not_if { ::Dir.exists?("/vagrant/app/cache")}
end

directory "/vagrant/app/logs" do
  owner "vagrant"
  group "vagrant"
  mode 00777
  action :create
  not_if { ::Dir.exists?("/vagrant/app/logs")}
end

execute "clear cache force" do
  cwd "/vagrant"
  command "rm -rf app/cache/*"
  action :run
end

# Assets

execute "assets install" do
  cwd "/vagrant"
  command "php app/console assets:install --symlink"
  action :run
end

execute "assetic dump" do
  cwd "/vagrant"
  command "php app/console assetic:dump"
  action :run
end

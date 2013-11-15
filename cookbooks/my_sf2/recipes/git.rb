#
# Author:: Alix Chaysinh (<alix.chaysinh@my_sf2.fr>)
# Cookbook Name:: my_sf2
# Recipe:: git

include_recipe "git"
include_recipe "vim"

template "/root/.gitconfig" do
  action :create_if_missing
  source "gitconfig.erb"
  owner "root"
  group "root"
  mode 00664
end

template "/home/vagrant/.gitconfig" do
  action :create_if_missing
  source "gitconfig.erb"
  owner "vagrant"
  group "vagrant"
  mode 00664
end
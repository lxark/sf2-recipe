#
# Author:: Alix Chaysinh (<alix.chaysinh@my_sf2.fr>)
# Cookbook Name:: my_sf2
# Recipe:: utils

# Utils

package "ack-grep" do
  action :install
end

package "htop" do
  action :install
end

# ssh

template "/home/vagrant/.ssh/config" do
  action :create_if_missing
  source "ssh_config.erb"
  owner "vagrant"
  group "vagrant"
  mode 00664
end

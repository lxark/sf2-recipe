# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "raring64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"
  #config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-i386-vagrant-disk1.box"
  config.vm.network :forwarded_port, guest: 80, host: 4242

  config.vm.network :private_network, ip: "192.168.33.10"
  # If application need public access
  #config.vm.network :public_network, ip: "192.168.0.199"
  config.vm.synced_folder ".", "/vagrant", :nfs => true


  # config.vm.provider :virtualbox do |vb|
  #  vb.gui = true
  #  # Workaround VM booting because of ssh login https://github.com/mitchellh/vagrant/issues/391
  #  vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
  # end

   config.vm.provision :chef_solo do |chef|
  #   chef.log_level = :debug
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_role "web"
     chef.cookbooks_path = "app/config/chef/cookbooks"
     chef.add_recipe "apt"
     chef.add_recipe "build-essential"
     chef.add_recipe "xml"
     chef.add_recipe "git"
     chef.add_recipe "vim"
     chef.add_recipe "mongodb::10gen_repo"
     chef.add_recipe "mongodb"
     chef.add_recipe "java"
     chef.add_recipe "php"
     chef.add_recipe "php::module_ldap"
     chef.add_recipe "php::module_curl"
     chef.add_recipe "php::module_mysql"
     chef.add_recipe "apache2::mod_php5"
     chef.add_recipe "apache2::mod_rewrite"
     chef.add_recipe "my_sf2::utils"
     chef.add_recipe "my_sf2::git"
     chef.add_recipe "my_sf2::php"
     chef.add_recipe "my_sf2::mongodb"
     chef.add_recipe "my_sf2::apache2"
     chef.add_recipe "my_sf2::symfony2"

     chef.json = {
        :my_sf2 => {
            :apache2 => {
                :server_name => "local.my_sf2.com",
                :server_aliases => %w{local.rc.com alix.rc.com}
            },
            :mongodb => {
                :user => "my_sf2",
                :pass => "my_sf2",
                :rockmongo_server_name => "local.rockmongo.my_sf2.com",
                :rockmongo_server_aliases => %w{alix.rm.rc.com local.rm.rc.com}
            },
            :git => {
                :user_name => "my_sf2 developer",
                :user_email => "johndoe@my_sf2.fr",
            }
        }
     }
   end
end

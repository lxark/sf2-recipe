#
# Author:: Alix Chaysinh (<alix.chaysinh@my_sf2.fr>)
# Cookbook Name:: my_sf2
# Recipe:: default

include_recipe "my_sf2::utils"
include_recipe "my_sf2::git"
include_recipe "my_sf2::php"
include_recipe "my_sf2::mongodb"
include_recipe "my_sf2::apache2"
include_recipe "my_sf2::tomcat7"
include_recipe "my_sf2::solr"
include_recipe "my_sf2::symfony2"
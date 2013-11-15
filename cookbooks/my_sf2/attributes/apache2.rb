#
# Author:: Alix Chaysinh (<alix.chaysinh@my_sf2.fr>)
# Cookbook Name:: my_sf2
# Attributes:: apache2

default['my_sf2']['apache2']['server_name'] = "local.my_sf2.com"
default['my_sf2']['apache2']['server_aliases'] = %w{local.rc.com}
#
# Author:: Alix Chaysinh (<alix.chaysinh@my_sf2.fr>)
# Cookbook Name:: my_sf2
# Attributes:: mongodb

default['my_sf2']['mongodb']['user'] = "my_sf2"
default['my_sf2']['mongodb']['pass'] = "my_sf2"

default['my_sf2']['mongodb']['rockmongo_server_name'] = "local.rockmongo.my_sf2.com"
default['my_sf2']['mongodb']['rockmongo_server_aliases'] = %w{local.rm.rc.com}

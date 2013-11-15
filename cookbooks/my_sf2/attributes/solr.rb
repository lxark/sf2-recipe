#
# Author:: Alix Chaysinh (<alix.chaysinh@my_sf2.fr>)
# Cookbook Name:: my_sf2
# Attributes:: solr

default["my_sf2"]["solr"]["download_site"]    = "http://apache.crihan.fr/dist/lucene/solr"
default["my_sf2"]["solr"]["version"]          = "4.4.0"
default["my_sf2"]["solr"]["url"]              = [ node["my_sf2"]["solr"]["download_site"], node["my_sf2"]["solr"]["version"], "solr-#{node["my_sf2"]["solr"]["version"]}.tgz" ].join("/")

default["my_sf2"]["solr"]["archive_war_path"] = ::File.join("solr-#{node["my_sf2"]["solr"]["version"]}", "dist", "solr-#{node["my_sf2"]["solr"]["version"]}.war")

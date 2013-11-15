#
# Author:: Alix Chaysinh (<alix.chaysinh@my_sf2.fr>)
# Cookbook Name:: my_sf2
# Recipe:: solr

require "pathname"

include_recipe "tomcat"

# Extract war file from solr archive
ark 'solr_war' do
  url node['my_sf2']['solr']['url']
  action :put
  path ::File.join(Chef::Config[:file_cache_path], 'solr')
  strip_leading_dir false
  not_if { ::File.directory?(::File.join(Chef::Config[:file_cache_path], 'solr')) }
end

# Symlink solr.war, contrib and dist repertories
solr_war_src = ::File.join(Chef::Config[:file_cache_path], 'solr', 'solr_war', node['my_sf2']['solr']['archive_war_path'])
solr_war_dest = ::File.join(node['tomcat']['base'], "webapps", "solr.war")
link solr_war_dest do
  to solr_war_src
  not_if { ::File.symlink?(solr_war_dest) }
end

dist_src = ::File.join(Chef::Config[:file_cache_path], 'solr', 'solr_war', 'solr-' + node["my_sf2"]["solr"]["version"], 'dist')
dist_dest = ::File.join(node['tomcat']['base'], "dist")
link dist_dest do
  to dist_src
  not_if { ::File.symlink?(dist_dest) }
end

contrib_src = ::File.join(Chef::Config[:file_cache_path], 'solr', 'solr_war', 'solr-' + node["my_sf2"]["solr"]["version"], 'contrib')
contrib_dest = ::File.join(node['tomcat']['base'], "contrib")
link contrib_dest do
  to contrib_src
  not_if { ::File.symlink?(contrib_dest) }
end


# Since solr 4.3.0 we need slf4j jar http://wiki.apache.org/solr/SolrLogging#Solr_4.3_and_above
# TODO use an external cookbook
["slf4j-jdk14-1.6.6.jar", "log4j-over-slf4j-1.6.6.jar", "slf4j-api-1.6.6.jar", "jcl-over-slf4j-1.6.6.jar"].each do |file|
  ark file do
    url "http://www.slf4j.org/dist/slf4j-1.6.6.tar.gz"
    action :cherry_pick
    creates ::File.join("slf4j-1.6.6", file)
    path ::File.join(node["tomcat"]["home"],"lib")
  end
end

# Create solr repertory in tomcat lib
solr_rep = ::File.join(node["tomcat"]["base"], "solr")

directory solr_rep do
  mode 00755
  action :create
  recursive true
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
  not_if { ::File.directory?(solr_rep) }
end


# Solr cores
cores_rep = "/vagrant/app/Resources/solr/cores"
cores = Array(Pathname.new(cores_rep).children.select { |c| c.directory? }.collect { |p| p.basename.to_s })

cores.each do |core|
  symlink = ::File.join(solr_rep, core)
  link symlink do
	to ::File.join(cores_rep, core)
  	owner node["tomcat"]["user"]
  	group node["tomcat"]["group"]
	not_if { ::File.symlink?(symlink) }
	notifies :restart, "service[tomcat]"
  end
end

# Solr.xml
template "solr.xml" do
  path ::File.join(solr_rep,"solr.xml")
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
  source "solr.xml.erb"
  variables(
    :collections => Array(cores.each {|core| core })
  )
  notifies :restart, "service[tomcat]"
end


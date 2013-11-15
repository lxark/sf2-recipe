#
# Author:: Alix Chaysinh (<alix.chaysinh@my_sf2.fr>)
# Cookbook Name:: my_sf2
# Recipe:: apache2

web_app "my_sf2" do
  server_name node['my_sf2']['apache2']['server_name']
  server_aliases node['my_sf2']['apache2']['server_aliases']
  docroot "/vagrant/web"
  directory_index %w{app.php}
  directory_options %w{Indexes MultiViews FollowSymLinks}
  allow_override %w{All}
end

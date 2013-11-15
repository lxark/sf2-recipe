maintainer       "my_sf2"
maintainer_email "alix.chaysinh@my_sf2.fr"
license          "my_sf2"
description      "my_sf2"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3"

recipe "my_sf2", "Installs all recipes"
recipe "my_sf2::utils", "Adds common config and packages"
recipe "my_sf2::git", "Adds generic gitconfig"
recipe "my_sf2::php", "Installs php dependencies for my_sf2"
recipe "my_sf2::mongodb", "Adds my_sf2 mongodb user and rockmongo"
recipe "my_sf2::apache2", "Installs my_sf2 webserver"
recipe "my_sf2::tomcat7", "Installs tomcat docs and examples"
recipe "my_sf2::solr", "Installs solr"
recipe "my_sf2::symfony2", "Installs symfony2 commands as composer install and assets install"

%w{debian ubuntu}.each do |os|
  supports os
end

depends "tomcat"
depends "apache2"
depends "php"
depends "mongodb"
depends "vim"
depends "git"

attribute "my_sf2/apache2/server_name",
  :display_name => "Url of the application",
  :description => "Url of the application accessible through browser",
  :default => "local.my_sf2.com"

attribute "my_sf2/apache2/server_aliases",
  :display_name => "Aliases url of the application",
  :description => "Array of url of the application accessible through browser",
  :default => %w{local.rc.com}

attribute "my_sf2/mongodb/rockmongo_server_name",
  :display_name => "Url for RockMongo",
  :description => "Url of RockMongo accessible through browser",
  :default => "local.rockmongo.my_sf2.com"

attribute "my_sf2/mongodb/rockmongo_server_aliases",
  :display_name => "Url of the application",
  :description => "Url of the application accessible through browser",
  :default =>  %w{local.rm.rc.com}

attribute "my_sf2/mongodb/user",
  :display_name => "MongoDB user",
  :description => "MongoDB user used by doctrine ODM",
  :default => "admin"

attribute "my_sf2/mongodb/pass",
  :display_name => "MongoDB user's password",
  :description => "MongoDB user's password used by doctrine ODM",
  :default => "admin"

attribute "my_sf2/git/user_name",
  :display_name => "Git username",
  :description => "Git username",
  :default => "my_sf2 developer"

attribute "my_sf2/git/user_email",
  :display_name => "Git user's email",
  :description => "Git user's email",
  :default => ""

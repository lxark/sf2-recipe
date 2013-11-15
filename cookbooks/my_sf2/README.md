Description
===========

Installs the project Rolling Cost (Symfony2).
When used with Vagrant, access to the application with your browser
http://local.my_sf2.com:4242

and RockMongo ( mongoDB database interface)
http://local.rm.rc.com:4242

and solr admin
http://local.my_sf2.com:4249/solr (tomcat port)

and tomcat webapp manager
http://local.my_sf2.com:4249 (tomcat port)

Before first "vagrant up", make sure :

1. you have your ssh-agent running with an available identity
see https://help.github.com/articles/using-ssh-agent-forwarding

2. you registered your vagrant public key on kara (ask for the password)
ssh-copy-id vagrant@kara

Observations :

1. Composer install can be really slow, "vagrant reload" if process timeout
or "vagrant ssh" and install manually

Don't forget to edit your hosts file ! (/etc/hosts)
127.0.0.1 local.my_sf2.com local.rm.rc.com

Requirements
============

## Platform:

* Ubuntu/Debian

Attributes
==========

Usage
=====

Changes
=======


License and Author
==================

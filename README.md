docker-for-modern-devs
======================

A docker image with a development environment for building bleeding edge web apps.

All apps are installed with apt-get for easy maintenance, except for supervisord, which is installed with easy\_install.

The following apps are installed with defaults:
* OpenSSH
* git
* node.js (with globals: bower, grunt-cli)
* nginx (config supplied)
* php-fpm
* MySQL (MariaDB)
* phpmyadmin
* MongoDB
* Redis (config supplied)
* Supervisord

# Details

## SSH

Root password: root

## Node.js

Some ports are exposed for convenience, but no process is listening yet:
* Port 3000
* Requests for http(s)://{hostname}/socket.io/ are forwarded to port 8080, also for convenience, but nobody is listening :p

## Nginx

Nginx is configured to listen on both port 80 and 443 for all "{hostname}.dev" hosts.
It expects an index file in either one of the following locations:

	/var/www/{hostname}
	/var/www/{hostname}/(public|httpdocs|web)

All static files are cached for a year.

## MySQL

Root password: root

## phpMyAdmin

phpMyAdmin can be found on:

	http(s):{hostname}/phpmyadmin/

Username: root
Password: root

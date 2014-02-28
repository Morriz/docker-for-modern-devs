docker-for-modern-devs
======================

A docker image with a development environment for building bleeding edge web apps.

# Usage

Examples:

	# Run with mounted host container
	$CID=$(docker run -d -v /var/www:/var/www -p 80:80 -p 443:443 -p 3000:3000)

	# attach to the running container
	docker attach $CID
	# CTRL-C to stop it, or CTRL-\ to stop with stacktrace 

	# stop the running container?
	docker stop $CID

For a complete overview please visit [docker.io](http://www.docker.io/)

# Packages

The following apps are installed with defaults:

* OpenSSH
* git
* node.js (with globals: bower, grunt-cli)
* nginx (config supplied)
* php-fpm
* MySQL
* phpMyAdmin
* Redis (config supplied)
* Supervisord

# Details

All apps are installed with apt-get for easy maintenance, except for supervisord, which is installed with easy\_install.

## SSH

Root password: root

## Node.js

Port 3000 is exposed for convenience, but no process is listening yet ;P

Requests for http(s)://{hostname}/socket.io/ are forwarded internally to port 8080.

## Nginx

Nginx is configured to listen on both port 80 and 443 for all "{hostname}.dev" hosts.
It expects an index file in either one of the following locations:

	/var/www/{hostname}
	/var/www/{hostname}/(public|httpdocs|web)

All static files are cached for a year.

## php-fpm

PHP comes with xdebug, which is configured to respond to all incoming profile and debug requests.

## MySQL

Root password: root

## phpMyAdmin

phpMyAdmin can be found on:

	http(s):{hostname}/phpmyadmin/

Username: root
Password: root

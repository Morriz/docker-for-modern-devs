# Docker Ultimate - a Docker image for developing modern web apps, running under Supervisord
#
# VERSION               0.0.1

FROM        ubuntu:12.10
MAINTAINER  Maurice Faber "morriz@idiotz.nl"

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# install certificates
ADD server.crt /etc/nginx/certificates/
ADD server.key /etc/nginx/certificates/

# install Supervisord conf
ADD supervisord.conf /etc/supervisord.conf

# RUN as much as possible from file to circumvent aufs 42 layer limit
ADD run.sh /tmp/run.sh
RUN /bin/bash /tmp/run.sh && rm /tmp/run.sh

# install nginx files
ADD nginx_default.conf /etc/nginx/sites-available/default
ADD websocket.conf /etc/nginx/sites-available/websocket.conf

# add redis files
ADD redis.conf /etc/redis/redis.conf

# expose ports - 3000 is default node.js app port
EXPOSE 22 80 443 3306 27017 6379 9000 3000

CMD supervisord -n -c /etc/supervisord.conf

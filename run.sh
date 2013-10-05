# Some fixes:
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

# Update packages
echo "deb http://archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
apt-get update

# install curl, telnet, wget, vim, locate
apt-get install -y curl telnet wget vim locate

# Install openssh and fix some dirs
mkdir /var/run/sshd
chmod 0755 /var/run/sshd
apt-get install -y openssh-server
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
sed 's/#PermitRootLogin yes/PermitRootLogin yes/' -i /etc/ssh/sshd_config
echo "root:root" | chpasswd

# Configure repos
apt-get install -y python-software-properties python python-setuptools ruby rubygems
add-apt-repository -y ppa:chris-lea/node.js
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
add-apt-repository -y ppa:nginx/stable
add-apt-repository -y ppa:ondrej/php5
apt-key adv --keyserver keyserver.ubuntu.com --recv C7917B12
echo 'deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu precise main' > /etc/apt/sources.list.d/chris-lea.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
add-apt-repository 'deb http://mirrors.supportex.net/mariadb/repo/10.0/ubuntu precise main'
apt-get update

# Install Git
apt-get install -y git-core

# Install node.js
apt-get install -y nodejs
# Install dependencies
npm install bower -g
npm install grunt-cli -g

# Install MariaDB - port 3306
echo mariadb-server mysql-server/root_password password root | debconf-set-selections
echo mariadb-server mysql-server/root_password_again password root | debconf-set-selections
apt-get -y install mariadb-server
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf
echo 'The default MYSQL root password is set to root' > /root/install_readme.txt
sed -i 's/^innodb_flush_method/#innodb_flush_method/' /etc/mysql/my.cnf

# Install nginx - port 80 + 443
apt-get -y install nginx

# Install PHP5 and modules
apt-get -y install php5-fpm php5-mysql php-apc php5-imagick php5-imap php5-mcrypt php5-xdebug
sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
tee /etc/php5/mods-available/xdebug.ini <<EOF
xdebug.profiler_output_dir=/tmp
xdebug.profiler_enable_trigger=1
xdebug.profiler_enable=0
xdebug.remote_enable=true
xdebug.remote_connect_back
xdebug.remote_port=9001
xdebug.remote_handler=dbgp
xdebug.remote_autostart=0
EOF
 
# Install redis
apt-get -y install redis-server || true

# Configure nginx for PHP websites -  php-fpm on port 9000
ln -s /etc/nginx/sites-available/websocket.conf /etc/nginx/sites-enabled/websocket.conf
echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
mkdir -p /var/www && chown -R www-data:www-data /var/www

# Supervisord
easy_install supervisor
printf "[include]\nfiles = /var/www/Supervisorfile\n" >> /etc/supervisord.conf


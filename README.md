AlexLarra dotfiles
===================


Simple configuration for zsh aliases and Git. For Linux.

----------


Installation
-------------

> source script/install.sh

Programs
-------------
 - gcc
 - make
 - mariadb (https://minhnguyeng.wordpress.com/2018/10/09/install-mysql-server-on-manjaro-16-10/)
   - sudo mysql_install_db –user=mysql –basedir=/usr –datadir=/var/lib/mysql
   - sudo systemctl enable mariadb
   - ALTER USER root@localhost IDENTIFIED VIA mysql_native_password;
   - SET PASSWORD = PASSWORD('');
 - redis (set /etc/redis.conf for systemctl work in arch):
   - supervised auto
   - daemonize no
 - alacritty
 - tmux
 - rvm
 - git
 - diff-so-fancy
 - vim
 - gvim (for copy to clipboard)
 - npm
   - npm install --global pure-prompt (https://github.com/sindresorhus/pure)
     ([Solution to posible problem](https://stackoverflow.com/a/55172709/2988753))
 - cmus
 - cointop
 - neofetch


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

OPENVPN Configuration
-------------

1 - Create UserPass file (/etc/openvpn/client/.vpn_auth):
* the first line should be the user and the second the pass

2 - Create client config file (/etc/openvpn/client/client.conf):
* Copy the content from one of the service config. For example: /etc/openvpn/fr-bod.prod.surfshark.com_udp.ovpn
* Specify user and pass: `auth-user-pass /etc/openvpn/client/.vpn_auth`

3 - Check if it works:
* `systemctl start openvpn-client@client.service`
* `systemctl status openvpn-client@client.service`

4 - For start on boot:
* `systemctl enable openvpn-client@client.service`

5 - Change DNS to be able to connect from everywhere (/etc/resolv.conf):
* nameserver 162.252.172.57
* nameserver 149.154.159.92

More info:
 * https://support.surfshark.com/hc/en-us/articles/360011051133-How-to-set-up-OpenVPN-using-Linux-Terminal
 * https://account.surfshark.com/setup/manual
 * https://wiki.archlinux.org/index.php/OpenVPN#Starting_OpenVPN

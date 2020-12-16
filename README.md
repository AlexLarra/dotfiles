AlexLarra dotfiles
===================


Simple configuration for bash aliases and Git. For Linux.

----------


Installation
-------------

> source script/install.sh

Programs
-------------
 - fish
 - rvm
 - git
 - diff-so-fancy

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

More info:
 * https://support.surfshark.com/hc/en-us/articles/360011051133-How-to-set-up-OpenVPN-using-Linux-Terminal
 * https://account.surfshark.com/setup/manual
 * https://wiki.archlinux.org/index.php/OpenVPN#Starting_OpenVPN

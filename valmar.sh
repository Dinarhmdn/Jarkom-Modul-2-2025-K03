auto eth0
iface eth0 inet static
    address 10.65.4.3
    netmask 255.255.255.0
    gateway 10.65.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# NO 4
apt update
apt install bind9 -y

nano /etc/bind/named.conf.local
zone "K03.com" {
  type slave;
  masters { 10.65.4.2; };
  file "/etc/bind/K03.com";
};

ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart
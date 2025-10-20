auto eth0
iface eth0 inet static
    address 10.65.4.2
    netmask 255.255.255.0
    gateway 10.65.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# No 4

apt update
apt install bind9 -y

nano /etc/bind/named.conf.local
zone "K03.com" {
  type master;
  notify yes;
  also-notify { 10.65.4.3; };
  allow-transfer { 10.65.4.3; };
  file "/etc/bind/K03.com";
  };

zone "4.65.10.in-addr.arpa" {
  type master;
  notify yes;
  also-notify { 10.65.4.3; };
  allow-transfer { 10.65.4.3; };
  file "/etc/bind/4.65.10.in-addr.arpa";
  };

nano /etc/bind/K03.com
$TTL    604800          ; Waktu cache default (detik)
@       IN      SOA     ns1.K03.com. root.K03.com. (
                        2025100401 ; Serial (format YYYYMMDDXX)
                        604800     ; Refresh (1 minggu)
                        86400      ; Retry (1 hari)
                        2419200    ; Expire (4 minggu)
                        604800 )   ; Negative Cache TTL
;

@       IN      NS      ns1.K04.com.
@       IN      NS      ns2.K03.com.
@       IN      A       10.65.4.5
ns1     IN      A       10.65.4.2
ns2     IN      A       10.89.3.3


nano /etc/bind/named.conf.options
options {
        directory "/var/cache/bind";

        dnssec-validation no;

        forwarders { 192.168.122.1;};
        allow-query { any; };
        auth-nxdomain no;
        listen-on-v6 { any; };
};

ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart

#No 5

nano /etc/bind/K03.com
eonwe     IN      A       192.168.122.247
earendil  IN      A       10.65.1.2
elwing    IN      A       10.65.1.3
cirdan    IN      A       10.65.2.2
elrond    IN      A       10.65.2.3
maglor    IN      A       10.65.2.4
sirion    IN      A       10.65.4.5
lindon    IN      A       10.65.4.4
vingilot  IN      A       10.65.4.5

service bind9 restart

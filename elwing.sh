auto eth0
iface eth0 inet static
    address 10.65.1.3
    netmask 255.255.255.0
    gateway 10.65.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# NO 4

cat <<EOF > /etc/resolv.conf
nameserver 10.65.4.2
nameserver 10.65.4.3
nameserver 192.168.122.1
EOF

# No 6 (selain server)

dig @10.65.4.2 ns2.K03.com SOA
dig @10.65.4.2 ns1.K03.com SOA



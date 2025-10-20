auto eth0
iface eth0 inet static
    address 10.65.2.3
    netmask 255.255.255.0
    gateway 10.65.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# No 5

cat <<EOF > /etc/resolv.conf
nameserver 10.65.4.2
nameserver 10.65.4.3
nameserver 192.168.122.1
EOF
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.65.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 10.65.2.1
    netmask 255.255.255.0

auto eth3
iface eth3 inet static
    address 10.65.4.1
    netmask 255.255.255.0

    up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.65.0.0/16

# No 5
cat <<EOF > /etc/resolv.conf
nameserver 10.65.4.2
nameserver 10.65.4.3
nameserver 192.168.122.1
EOF

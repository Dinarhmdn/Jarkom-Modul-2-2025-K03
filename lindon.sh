#!/bin/bash
# Konfigurasi IP untuk Lindon (DMZ)

echo "=== Konfigurasi Lindon (DMZ) ==="

ip addr add 10.15.43.133/27 dev eth0
ip link set eth0 up

ip route add default via 10.15.43.129
echo "nameserver 192.168.122.1" > /etc/resolv.conf

echo "✅ Konfigurasi Lindon selesai"


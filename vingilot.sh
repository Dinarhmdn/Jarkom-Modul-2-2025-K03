#!/bin/bash
# Konfigurasi IP untuk Vingilot (DMZ)

echo "=== Konfigurasi Vingilot (DMZ) ==="

ip addr add 10.15.43.134/27 dev eth0
ip link set eth0 up

ip route add default via 10.15.43.129
echo "nameserver 192.168.122.1" > /etc/resolv.conf

echo "✅ Konfigurasi Vingilot selesai"


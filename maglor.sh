#!/bin/bash
# Konfigurasi IP untuk Maglor (host Timur)

echo "=== Konfigurasi Maglor (Timur) ==="

ip addr add 10.15.43.100/27 dev eth0
ip link set eth0 up

ip route add default via 10.15.43.97
echo "nameserver 192.168.122.1" > /etc/resolv.conf

echo "✅ Konfigurasi Maglor selesai"


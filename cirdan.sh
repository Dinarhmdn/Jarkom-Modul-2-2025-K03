#!/bin/bash
# Konfigurasi IP untuk Cirdan (host Timur)

echo "=== Konfigurasi Cirdan (Timur) ==="

ip addr add 10.15.43.98/27 dev eth0
ip link set eth0 up

ip route add default via 10.15.43.97
echo "nameserver 192.168.122.1" > /etc/resolv.conf

echo "✅ Konfigurasi Cirdan selesai"


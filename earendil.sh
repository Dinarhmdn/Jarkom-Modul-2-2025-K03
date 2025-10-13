#!/bin/bash
# Konfigurasi IP untuk Earendil (host Barat)

echo "=== Konfigurasi Earendil (Barat) ==="

ip addr add 10.15.43.66/27 dev eth0
ip link set eth0 up

ip route add default via 10.15.43.65

echo "nameserver 192.168.122.1" > /etc/resolv.conf

echo "✅ Konfigurasi Earendil selesai"


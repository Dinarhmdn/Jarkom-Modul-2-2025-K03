#!/bin/bash
# Konfigurasi IP untuk Elrond (host Timur)

echo "=== Konfigurasi Elrond (Timur) ==="

ip addr add 10.15.43.99/27 dev eth0
ip link set eth0 up

ip route add default via 10.15.43.97
echo "nameserver 192.168.122.1" > /etc/resolv.conf

echo "✅ Konfigurasi Elrond selesai"


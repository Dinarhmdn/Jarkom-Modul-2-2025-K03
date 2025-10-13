#!/bin/bash

# Script: 1-setup-eonwe.sh
# Konfigurasi IP Address untuk Eonwe (Router)

echo "=== Konfigurasi Eonwe (Router) ==="

ip addr add 10.15.43.32/24 dev eth0
ip link set eth0 up

ip addr add 10.15.43.65/27 dev eth1
ip link set eth1 up

ip addr add 10.15.43.97/27 dev eth2
ip link set eth2 up

ip addr add 10.15.43.129/27 dev eth3
ip link set eth3 up

echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
sysctl -p

echo "✅ Konfigurasi Eonwe selesai"


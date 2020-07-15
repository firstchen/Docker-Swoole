#!/bin/sh

# Load Config
redis-server /etc/redis.conf

# TCP Fix
echo 511 > /proc/sys/net/core/somaxconn

# THP Fix
echo never > /sys/kernel/mm/transparent_hugepage/enabled
touch /etc/rc.local
echo 'echo never > /sys/kernel/mm/transparent_hugepage/defrag' >> /etc/rc.local
echo 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' >> /etc/rc.local
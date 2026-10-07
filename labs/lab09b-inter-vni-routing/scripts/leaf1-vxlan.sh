#!/bin/sh

# -------------------------
# VRF TENANT-A
# -------------------------

ip link add TENANT-A type vrf table 10
ip link set TENANT-A up

# -------------------------
# VNI 10100
# -------------------------

ip link add br100 type bridge
ip link set br100 master TENANT-A
ip link set br100 up

# Anycast Gateway - VLAN 100

ip link set br100 address 02:00:00:00:00:01
ip addr add 192.168.100.1/24 dev br100

ip link set eth2 master br100
ip link set eth2 up

ip link add vxlan10100 type vxlan \
    id 10100 \
    local 10.255.1.1 \
    dstport 4789 \
    nolearning

ip link set vxlan10100 master br100
ip link set vxlan10100 up

# -------------------------
# VNI 10200
# -------------------------

ip link add br200 type bridge
ip link set br200 master TENANT-A
ip link set br200 up

# Anycast Gateway - VLAN 200

ip link set br200 address 02:00:00:00:00:01
ip addr add 192.168.200.1/24 dev br200

ip link set eth3 master br200
ip link set eth3 up

ip link add vxlan10200 type vxlan \
    id 10200 \
    local 10.255.1.1 \
    dstport 4789 \
    nolearning

ip link set vxlan10200 master br200
ip link set vxlan10200 up

# -------------------------
# L3VNI 10000 / TENANT-A
# -------------------------

ip link add br10000 type bridge
ip link set br10000 master TENANT-A
ip link set br10000 address 02:00:00:00:01:01
ip link set br10000 up

ip link add vxlan10000 type vxlan \
    id 10000 \
    local 10.255.1.1 \
    dstport 4789 \
    nolearning

ip link set vxlan10000 master br10000
ip link set vxlan10000 up

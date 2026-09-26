#!/bin/sh

# -------------------------
# VNI 10100 / VLAN 100
# -------------------------

ip link add br100 type bridge
ip link set br100 up

ip link set eth2 master br100
ip link set eth2 up

ip link add vxlan10100 type vxlan \
    id 10100 \
    local 10.255.1.2 \
    dstport 4789 \
    nolearning

ip link set vxlan10100 master br100
ip link set vxlan10100 up


# -------------------------
# VNI 10200 / VLAN 200
# -------------------------

ip link add br200 type bridge
ip link set br200 up

ip link set eth3 master br200
ip link set eth3 up

ip link add vxlan10200 type vxlan \
    id 10200 \
    local 10.255.1.2 \
    dstport 4789 \
    nolearning

ip link set vxlan10200 master br200
ip link set vxlan10200 up

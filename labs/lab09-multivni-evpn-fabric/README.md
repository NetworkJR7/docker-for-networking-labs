# Lab09A – Multi-VNI EVPN Fabric

This lab extends the previous EVPN foundations lab by introducing multiple Layer 2 VNIs across the same VXLAN/EVPN fabric.

The objective is to demonstrate how multiple isolated Layer 2 segments can be transported over a shared IP underlay while using BGP EVPN as the control plane.

---

## Topology

```text
                         Spine
                        AS65000
                      /         \
                     /           \
                Leaf1             Leaf2
               AS65101           AS65102
              /      \           /      \
           HostA    HostB     HostC    HostD
```

### Segment Mapping

```text
VLAN 100 / VNI 10100
HostA 192.168.100.10/24
HostC 192.168.100.20/24

VLAN 200 / VNI 10200
HostB 192.168.200.10/24
HostD 192.168.200.20/24
```

---

## Underlay

The underlay uses eBGP IPv4 between the Leafs and the Spine.

### Leaf1

```text
AS: 65101
eth1: 10.10.19.1/30
Loopback: 10.255.1.1/32
```

### Spine

```text
AS: 65000

eth1: 10.10.19.2/30
eth2: 10.10.19.6/30

Loopback: 10.255.1.254/32
```

### Leaf2

```text
AS: 65102
eth1: 10.10.19.5/30
Loopback: 10.255.1.2/32
```

The Spine acts only as an underlay transit router.

---

## EVPN Overlay

The EVPN control plane is established directly between the Leaf VTEP loopbacks.

```text
Leaf1 VTEP: 10.255.1.1
Leaf2 VTEP: 10.255.1.2
```

The EVPN session uses eBGP multihop.

```text
Leaf1 AS65101 <------ BGP EVPN ------> Leaf2 AS65102
```

---

## VXLAN Services

Two independent Layer 2 VNIs are deployed.

| Segment | VNI | Route Target |
|---|---:|---|
| VLAN 100 | 10100 | 65000:10100 |
| VLAN 200 | 10200 | 65000:10200 |

Both VNIs use:

```text
UDP destination port: 4789
```

---

## Linux Bridge Mapping

### Leaf1

```text
HostA
  |
 eth2
  |
br100
  |
vxlan10100
  |
VNI 10100
```

```text
HostB
  |
 eth3
  |
br200
  |
vxlan10200
  |
VNI 10200
```

### Leaf2

```text
HostC
  |
 eth2
  |
br100
  |
vxlan10100
  |
VNI 10100
```

```text
HostD
  |
 eth3
  |
br200
  |
vxlan10200
  |
VNI 10200
```

---

## EVPN Type-3 Routes

After creating the VXLAN interfaces, both Leafs advertise EVPN Type-3 IMET routes for each VNI.

Example:

```text
Route Distinguisher: 10.255.1.1:2

[3]:[0]:[32]:[10.255.1.1]
RT:65000:10100
```

and:

```text
Route Distinguisher: 10.255.1.1:3

[3]:[0]:[32]:[10.255.1.1]
RT:65000:10200
```

This confirms that each VTEP participates in both VNIs.

---

## EVPN Type-2 Routes

After generating traffic from the hosts, MAC addresses are learned locally and advertised through BGP EVPN as Type-2 routes.

Example on Leaf1:

```text
VNI 10100

aa:c1:ab:3e:4f:a8 local  eth2
aa:c1:ab:09:4b:71 remote 10.255.1.2
```

For VNI 10200:

```text
aa:c1:ab:77:ad:da local  eth3
aa:c1:ab:95:da:5f remote 10.255.1.2
```

Leaf2 sees the inverse relationship.

This demonstrates EVPN control-plane MAC learning.

---

## BGP EVPN Table

After the hosts generate traffic, the EVPN table contains:

```text
4 x Type-2 MAC Advertisement routes
4 x Type-3 IMET routes
```

Total:

```text
8 EVPN prefixes
```

Example verification:

```bash
docker exec clab-lab09-leaf1 \
vtysh -c "show bgp l2vpn evpn"
```

---

## Verification

### Check EVPN VNIs

```bash
docker exec clab-lab09-leaf1 \
vtysh -c "show evpn vni"

docker exec clab-lab09-leaf2 \
vtysh -c "show evpn vni"
```

Expected VNIs:

```text
10100
10200
```

Each VNI should show one remote VTEP.

---

### Check EVPN MAC Learning

```bash
docker exec clab-lab09-leaf1 \
vtysh -c "show evpn mac vni 10100"

docker exec clab-lab09-leaf1 \
vtysh -c "show evpn mac vni 10200"
```

The local host MAC should appear as:

```text
local
```

and the remote host MAC should point to the remote VTEP.

---

## Connectivity Tests

### VNI 10100

```bash
docker exec clab-lab09-hosta \
ping -c 4 192.168.100.20
```

Result:

```text
0% packet loss
```

### VNI 10200

```bash
docker exec clab-lab09-hostb \
ping -c 4 192.168.200.20
```

Result:

```text
0% packet loss
```

---

## VNI Isolation

Traffic between different VNIs fails because no inter-VNI routing exists.

Example:

```bash
docker exec clab-lab09-hosta \
ping -c 3 192.168.200.20
```

Result:

```text
100% packet loss
```

This is expected behavior.

```text
VNI 10100
   X
VNI 10200
```

The two Layer 2 domains remain isolated even though they use the same physical fabric.

---

## Troubleshooting

### Problem: `show evpn vni` displayed no VNIs

Initially:

```text
VNI        Type VxLAN IF ...
```

but no entries appeared.

The reason was that the Linux VXLAN interfaces had not been created.

Verification:

```bash
docker exec clab-lab09-leaf1 \
ip -d link show vxlan10100
```

returned:

```text
Device "vxlan10100" does not exist.
```

The VXLAN setup scripts were executed again:

```bash
docker cp scripts/leaf1-vxlan.sh \
clab-lab09-leaf1:/tmp/leaf1-vxlan.sh

docker exec clab-lab09-leaf1 \
sh /tmp/leaf1-vxlan.sh
```

After that:

```bash
docker exec clab-lab09-leaf1 \
ip -br link
```

showed:

```text
br100
br200
vxlan10100
vxlan10200
```

and FRR correctly detected both VNIs.

---

## Important Operational Lesson

FRR configuration is persistent because `/etc/frr` is mounted from the host.

However, Linux interfaces created dynamically inside the container are not persistent after a Containerlab redeploy.

Objects such as:

```text
br100
br200
vxlan10100
vxlan10200
```

must be recreated after the containers are rebuilt.

This is why the VXLAN configuration is stored in reusable scripts.

---

## Key Concepts

This lab demonstrates the separation between three different network layers.

### Underlay

```text
eBGP IPv4
```

Provides IP reachability between VTEPs.

### Overlay Control Plane

```text
BGP EVPN
```

Distributes VTEP participation and MAC reachability.

### Data Plane

```text
VXLAN
UDP/4789
```

Carries the encapsulated Layer 2 traffic.

---

## Main Learning Outcomes

- Multi-VNI EVPN operation
- Multiple Layer 2 services over a common underlay
- EVPN Type-2 MAC advertisement
- EVPN Type-3 IMET advertisement
- Route Target based service separation
- Remote MAC learning through BGP EVPN
- VXLAN VTEP forwarding
- VNI isolation
- Linux bridges and VXLAN interfaces
- EVPN troubleshooting methodology

---

## Next Step

The next evolution of this fabric is:

```text
Lab09B – Inter-VNI Routing
```

Topics:

```text
Anycast Gateway
L3VNI
Symmetric IRB
EVPN Type-5
```

This will allow communication between hosts located in different VNIs while preserving the EVPN/VXLAN fabric architecture.

# Docker for Networking Labs

![Docker](images/docker-logo.png)

Docker fundamentals and networking labs focused on network engineers.


## Overview

Docker has become one of the most important technologies in modern IT infrastructures. It enables engineers to deploy applications, network services, and testing environments quickly and consistently using lightweight containers.

For network engineers, Docker provides an efficient way to build routing labs, test network services, validate configurations, and learn modern datacenter technologies without requiring multiple virtual machines.

This repository introduces Docker from a networking perspective and includes practical examples using Linux networking tools and FRRouting.

---

## What is Docker?

Docker is a containerization platform that allows applications and services to run in isolated environments called containers.

Unlike traditional virtual machines, containers share the host operating system kernel, making them:

* Lightweight
* Fast to deploy
* Portable
* Resource efficient
* Easy to automate

### Virtual Machines vs Containers

| Virtual Machines                | Containers                |
| ------------------------------- | ------------------------- |
| Include a full operating system | Share the host kernel     |
| Higher resource consumption     | Lightweight               |
| Slower startup times            | Start in seconds          |
| Larger disk usage               | Minimal storage footprint |

---

## Why Docker Matters for Network Engineers

Docker is widely used in networking because it allows engineers to:

* Build routing and switching labs
* Test BGP and OSPF configurations
* Simulate network services
* Validate automation scripts
* Deploy monitoring tools
* Create reproducible environments

Many modern network operating systems and lab platforms rely on container technology.

Examples include:

* FRRouting (FRR)
* Containerlab
* SR Linux
* SONiC
* Network automation environments

---

## Core Docker Concepts

### Images

A Docker image is a template used to create containers.

Examples:

```bash
docker pull ubuntu
docker pull alpine
docker pull frrouting/frr
```

### Containers

A running instance of an image.

```bash
docker run -it ubuntu bash
```

### Volumes

Used to persist data.

```bash
docker volume create lab-data
```

### Networks

Docker can create virtual networks for container communication.

```bash
docker network create lab-net
```

---

## Basic Docker Commands

### Check Docker Version

```bash
docker version
```

### List Running Containers

```bash
docker ps
```

### List All Containers

```bash
docker ps -a
```

### Download an Image

```bash
docker pull ubuntu
```

### Start a Container

```bash
docker run -it ubuntu bash
```

### Stop a Container

```bash
docker stop <container-id>
```

### Remove a Container

```bash
docker rm <container-id>
```

### Remove an Image

```bash
docker rmi <image-id>
```

---

## Docker Networking

Docker provides several network drivers.

### Bridge Network

Default Docker network.

```bash
docker network create lab-net
```

### Host Network

The container uses the host networking stack.

```bash
docker run --network host ubuntu
```

### Macvlan

Assigns an IP address directly from the physical network.

Useful for networking labs and testing.

---

## Networking Containers Commonly Used

### FRRouting

Open-source routing suite supporting:

* BGP
* OSPF
* IS-IS
* RIP
* BFD
* VRRP

Docker image:

```bash
docker pull frrouting/frr
```

### Netshoot

Excellent troubleshooting container.

Includes:

* ping
* traceroute
* dig
* tcpdump
* curl
* netcat

```bash
docker pull nicolaka/netshoot
```

### Ubuntu

General-purpose Linux environment.

```bash
docker pull ubuntu
```

### Alpine Linux

Lightweight Linux distribution.

```bash
docker pull alpine
```

---

## Practical Networking Use Cases

### BGP Lab

Deploy multiple FRRouting containers to establish BGP adjacencies.

### OSPF Lab

Create an OSPF area using Docker networks and FRR containers.

### Network Troubleshooting

Use Netshoot containers for:

* Packet captures
* DNS testing
* Connectivity validation

### Automation Testing

Validate Python and Ansible playbooks safely before production deployment.

---

## Future Labs

* Docker Networking Fundamentals
* Linux Networking Inside Containers
* FRRouting OSPF Lab
* FRRouting BGP Lab
* Containerlab Introduction
* EVPN/VXLAN Concepts with Containers

---

## Skills Demonstrated

* Docker Fundamentals
* Linux Networking
* Routing Protocols
* FRRouting
* Troubleshooting
* Network Automation
* Datacenter Networking Concepts

---

## Author

Jaime Rosero

Network Engineer | CCNA | CCNP Enterprise (In Progress)

GitHub: NetworkJR7

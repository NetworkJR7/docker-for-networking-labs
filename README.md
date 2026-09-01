# Docker for Networking Labs

> **Learn Docker from a Network Engineer's perspective through progressive documentation and hands-on labs.**

<p align="center">
  <img src="images/docker-logo.png" width="250">
</p>

![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=black)
![FRRouting](https://img.shields.io/badge/FRRouting-Networking-blue)
![OSPF](https://img.shields.io/badge/OSPF-Lab-success)

A hands-on learning repository focused on Docker, Linux networking, FRRouting and modern network lab environments.

The project combines practical labs, troubleshooting workflows and standardized technical diagrams designed from a Network Engineer's perspective. 

# 📚 Learning Path

This repository is organized as a progressive learning path for Network Engineers interested in Docker and modern networking technologies.

## Documentation

| Document | Status |
|----------|--------|
- [Docker Fundamentals](docs/01-what-is-docker.md) | ✅ |
- [Docker Basic Concepts](docs/02-docker-basic-concepts.md) | 🟡 |
- [Docker in Networking](docs/03-docker-in-networking.md) | 🚧 |
- [Useful Networking Containers](docs/04-useful-networking-containers.md) | 🚧 |

---

## Hands-on Labs

| Lab | Topic | Status |
|---|---|---|
| [Lab01](labs/lab01-linux-container/) | Linux Containers | ✅ |
| [Lab02](labs/lab02-docker-bridge-network/) | Docker Bridge | ✅ |
| [Lab03](labs/lab03-frr-ospf/) | FRRouting OSPF | ✅ |
| [Bonus01](labs/bonus01-docker-volumes/) | Docker Volumes / Bind Mounts | ✅ |
| [Lab04](labs/lab04-frr-bgp/) | FRRouting eBGP | ✅ |
| [Lab05](labs/lab05-containerlab-intro/) | Containerlab Introduction | ✅ |


---

## Visual Documentation Standard

The hands-on labs use the **NetworkJR7 Design System** to maintain a consistent visual language across networking diagrams and technical documentation.

Standardized topology diagrams are currently included in:

- Lab01 – Linux Container
- Lab02 – Docker Bridge Network
- Lab03 – FRRouting OSPF
- Bonus01 – Docker Volumes / Bind Mounts
- Lab04 – FRRouting eBGP
- Lab05 – Containerlab Introduction

The diagrams follow common standards for:

- Component size and spacing
- Typography
- Network labels
- Connector semantics
- White background
- Consistent export margins
- GitHub-friendly PNG output

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

## Skills Demonstrated

* Docker Fundamentals
* Linux Networking
* Docker Compose
* Containerized Networking
* Routing Protocols
* FRRouting
* Troubleshooting
* Network Automation
* Datacenter Networking Concepts

---


## Roadmap

- [x] Lab01 – Linux Container Fundamentals
- [x] Lab02 – Docker Bridge Networking
- [x] Lab03 – FRRouting OSPF
- [x] Bonus01 – Docker Volumes and Bind Mounts
- [x] Lab04 – FRRouting BGP
- [x] Lab05 – Containerlab Introduction
- [ ] Lab06 – Multi-Router BGP
- [ ] Lab07 – VXLAN / EVPN Foundations

---

## Repository Structure

```text
docker-for-networking-labs
│
├── docs/
├── labs/
├── images/
└── README.md
```
---


## Repository Statistics

- 📚 Documentation Guides: 4
- 🧪 Hands-on Labs: 4
- 🐳 Docker Technologies: Containers, Networks, Volumes, Compose
- 🌐 Routing Protocols: OSPF (Completed), BGP (Planned)

## Author

Jaime Rosero

Network Engineer | CCNA | CCNP Enterprise (In Progress)

GitHub: NetworkJR7

---

## About this Project

This repository is continuously updated with new networking labs as part of my professional learning journey toward modern Data Center Networking and Network Automation.

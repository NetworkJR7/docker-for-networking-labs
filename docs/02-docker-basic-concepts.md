# Docker Basic Concepts

## Docker Images

A Docker image is a read-only template used to create containers.

Images contain:

- Operating system components
- Libraries
- Dependencies
- Applications

Examples:

```bash
docker pull ubuntu
docker pull alpine
docker pull frrouting/frr
```

To view downloaded images:

```bash
docker images
```
## Containers

A container is a running instance of a Docker image.

Containers provide isolated environments where applications and services can run independently from the host system and other containers.

Unlike virtual machines, containers share the host operating system kernel, making them lightweight and efficient.

### Create a Container

```bash
docker run -it ubuntu bash
```

### List Running Containers

```bash
docker ps
```

### List All Containers

```bash
docker ps -a
```

### Stop a Container

```bash
docker stop <container-id>
```

### Remove a Container

```bash
docker rm <container-id>
```

---

## Volumes

Volumes are used to persist data outside the container lifecycle.

By default, data stored inside a container is lost when the container is removed. Volumes allow data to remain available even after containers are deleted or recreated.

### Create a Volume

```bash
docker volume create my-volume
```

### List Volumes

```bash
docker volume ls
```

### Inspect a Volume

```bash
docker volume inspect my-volume
```

### Example

```bash
docker run -it -v my-volume:/data ubuntu bash
```

In this example, the directory `/data` inside the container is mapped to the Docker volume `my-volume`.

---

## Networks

Docker networks enable communication between containers and external systems.

Docker automatically creates virtual networks that allow containers to exchange traffic.

### List Existing Networks

```bash
docker network ls
```

### Create a Network

```bash
docker network create lab-net
```

### Inspect a Network

```bash
docker network inspect lab-net
```

### Connect a Container to a Network

```bash
docker network connect lab-net my-container
```

### Common Network Types

| Network Type | Description                                        |
| ------------ | -------------------------------------------------- |
| Bridge       | Default network for container communication        |
| Host         | Container uses the host network stack              |
| None         | No networking assigned                             |
| Macvlan      | Container receives an IP from the physical network |

For network engineers, bridge and macvlan networks are particularly useful for building routing and connectivity labs.

---

## Docker Hub

Docker Hub is the official public repository for Docker images.

It allows users to download, share, and distribute container images.

Website:

https://hub.docker.com

### Download an Image

```bash
docker pull ubuntu
```

### Download FRRouting

```bash
docker pull frrouting/frr
```

### Download Alpine Linux

```bash
docker pull alpine
```

### Search for Images

```bash
docker search ubuntu
```

Docker Hub contains thousands of images, including:

* Ubuntu
* Debian
* Alpine Linux
* FRRouting
* Nginx
* Apache
* MySQL
* PostgreSQL
* Redis

For networking labs, FRRouting, Ubuntu, Alpine, and Netshoot are among the most commonly used images.


## Summary

The four fundamental Docker components are:

- Images: Templates used to create containers
- Containers: Running instances of images
- Volumes: Persistent storage for data
- Networks: Connectivity between containers
- Docker Hub: Public repository for container images

Understanding these concepts is essential before building networking labs with Docker and FRRouting.

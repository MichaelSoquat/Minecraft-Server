# Minecraft Server Docker Setup

## Table of Contents
- [Minecraft Server Docker Setup](#minecraft-server-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Quickstart](#quickstart)
  - [Requirements:](#requirements)
  - [Usage:](#usage)


## Description
This repository provides a Docker setup for hosting a Minecraft server. It includes:
- A `docker-compose.yaml` for server configuration and port forwarding.
- A `Dockerfile` that installs Java and runs the Minecraft server.
- Minecraft as a `server.jar`.

The goal is to quickly deploy a Minecraft server in an isolated Docker container with persistent data.

## Quickstart
Clone the repository:

   ```
   git clone https://github.com/your-username/minecraft-server-docker.git
   cd minecraft-server-docker
   ```
   
Start the server:

  ```
  docker compose up
  ```

Access the server on port 8888 (forwarded to Minecraft port 25565).

## Requirements:
- Installed [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/).
- server.jar from https://www.minecraft.net/de-de/download/server
- Already inside the repo if you clone it
  
## Usage:

Stop the server:

  ```
  docker compose down
  ```

Dockerfile:
The Dockerfile installs Java and runs the Minecraft server:

  ```
  Dockerfile

  FROM ubuntu:22.04

  WORKDIR /app

  RUN apt-get update && \
    apt-get install -y wget openjdk-21-jdk && \
    rm -rf /var/lib/apt/lists/*

  COPY server.jar /app/
  RUN echo "eula=true" > eula.txt

  EXPOSE 25565

  ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
  ```

docker-compose.yaml:
Defines the server setup, port forwarding, and persistent storage:

  ```
  services:
    mc-server:
      build:
        context: .
      container_name: mc-server
      ports:
        - "8888:25565"
      volumes:
        - mc-data:/app
      restart: on-failure

  volumes:
    mc-data:
  ```

Port: Host port 8888 maps to container port 25565.
Volume: mc-data ensures game data persistence.
Volumes and Data Persistence
The game world and server data are stored in the mc-data volume, mapped to /app in the container. Data persists across container restarts.

To inspect the volume:

  ```
  docker volume inspect mc-data
  ```

##Troubleshooting
Server not starting: Check logs with:

```
docker logs mc-server
```

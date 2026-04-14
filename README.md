
# Inception: A Multi-Service Docker Infrastructure

## 📝 Description

This project aims to broaden knowledge of **system administration** by using **Docker**. It involves virtualizing several Docker images in a personal virtual machine to set up a small infrastructure composed of different services.

The architecture is built for security and stability, using **TLSv1.2/1.3** as the exclusive entry point and ensuring data persistence through **Docker named volumes**.

## 🛠️ Infrastructure Overview

### Mandatory Services

- **NGINX**: The only entry point to the infrastructure via port 443 using TLSv1.2 or TLSv1.3.
- **WordPress + php-fpm**: Installed and configured to run without Nginx in its own dedicated container.
- **MariaDB**: The dedicated database container for the WordPress site.
- **Docker Network**: A dedicated network that establishes the connection between containers.
- **Persistence**: Two named volumes used for the WordPress database and website files. These store data on the host at `/home/oaoulad-/data`.

### Bonus Features

I expanded the infrastructure with several advanced services, each running in its own container:

- **Redis Cache**: Implemented for the WordPress website to properly manage caching.
- **FTP Server**: Provides access to the WordPress website volume.
- **Static Website**: A secondary showcase site built without using PHP.
- **Adminer**: A lightweight database management tool.
- **Container Monitor**: A custom-built dashboard to visualize the real-time status of all active containers.


## 🚀 Instructions

### 1. Local DNS Configuration (Required)

The project requires the domain name `oaoulad-.42.fr` to point to your local IP address.

Edit your `/etc/hosts` file:
```bash
sudo nano /etc/hosts
```

Add the following line:
```text
127.0.0.1  oaoulad-.42.fr
```

### 2. Installation & Execution

- **Setup**: Place your `.env` file containing required environment variables in the `srcs/` directory.
- **Launch**: Use the provided **Makefile** at the root of the directory.
```bash
make        # Builds the images using docker-compose.yml and starts the stack
```

### 3. Management Commands

| Command | Description |
|---------|-------------|
| `make` or `make all` | Build images and start the stack |
| `make status` | Check the status of the containers |
| `make down` | Stop the infrastructure |
| `make clean` | Stop containers and prune system |
| `make fclean` | Full cleanup, including the removal of volumes |
| `make logs` | View real-time container logs |
| `make redis-up` | Start Redis bonus service |
| `make adminer-up` | Start Adminer bonus service |
| `make ftp-up` | Start FTP bonus service |
| `make static-up` | Start static website bonus service |

### 4. Access Points

| Service | URL |
|---------|-----|
| WordPress Website | `https://oaoulad-.42.fr` |
| Adminer | `http://localhost:8080` |
| Static Site | `http://localhost:3000` |
| Monitor Dashboard | `http://localhost:8082` |
| FTP Server | `ftp://localhost:21` |

---

## 🧠 Technical Choices

### Virtual Machines vs. Docker
While VMs emulate hardware, Docker containers share the host's kernel, making them more lightweight. However, containers are not VMs and require careful management of PID 1.

### Secrets vs. Environment Variables
Environment variables are used for general configuration, while it is strongly recommended to use Docker secrets for confidential information. Any credentials found publicly result in project failure.

### Docker Network vs. Host Network
Using `network: host` is strictly forbidden. A dedicated bridge network ensures isolation and controlled communication between services.

### Docker Volumes vs. Bind Mounts
Bind mounts are not allowed for the primary persistent storage. Named volumes ensure data persists correctly in a Docker-managed way, stored in `/home/oaoulad-/data/`.

---

### Resources

- [Docker Documentation](https://docs.docker.com/)
- [NGINX TLS Configuration](https://nginx.org/en/docs/http/configuring_https_servers.html)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)

---






# Secure Web APIs with Nginx and SSL
This project demonstrates how to set up two web APIs (Django Ninja and FastAPI) running in Docker containers, and securely expose them over HTTPS using Nginx as a reverse proxy. The project includes steps for configuring subdomains, obtaining SSL certificates with Certbot, and routing traffic to the appropriate services.

That sounds like a fantastic idea! Publishing your mini-project on GitHub can showcase your skills and serve as a reference for others. Here’s a suggestion for naming your repository and what to include in your README:


## Table of Contents
- [Prerequisites](#prerequisites)
- [Setup](#setup)
  - [1. Setup Azure VM](#1-setup-azure-vm)
  - [2. Install Docker](#2-install-docker)
  - [3. Create Minimal Web APIs](#3-create-minimal-web-apis)
  - [4. Dockerize the Web APIs](#4-dockerize-the-web-apis)
  - [5. Run Docker Containers](#5-run-docker-containers)
  - [6. Configure Domain and Subdomains](#6-configure-domain-and-subdomains)
  - [7. Install and Configure Nginx](#7-install-and-configure-nginx)
  - [8. Obtain SSL Certificates](#8-obtain-ssl-certificates)
  - [9. Finalize Nginx Configuration](#9-finalize-nginx-configuration)
- [Testing](#testing)
- [Closing External Ports](#closing-external-ports)
- [Conclusion](#conclusion)


## Prerequisites
- Azure account
- Domain name (e.g., purchased from GoDaddy)
- Basic knowledge of Docker, Nginx, and SSL/TLS

## Steps

### 1. Setup Azure VM
- Create a VM in Azure.
- Ensure it has a static public IP address.


### 2. Install Docker

Pleaes follow [this tutorial by DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04).

### 3. Create Minimal Web APIs

We will create two minimal and simple Web APIs using two different Python backend frameworks. The tutorials in the following articles should be sufficient:

- [Django Ninja Tutorial - First Steps](https://django-ninja.dev/tutorial/)
- [FastAPI Tutorial - First Steps](https://fastapi.tiangolo.com/tutorial/first-steps/)

### 4. Dockerize the Web APIs

TODO: Include `Dockerfile`s in this section.

### 5. Run Docker Containers

Run the following Docker commands in Azure VM:

```bash
docker run -d -p 8081:8081 --name django_ninja_container django_ninja_image
docker run -d -p 8082:8082 --name fast_api_container fast_api_image
```

**NOTE**: It might be worth accessing the two Web APIs via `http` for testing purposes; ports will be closed later on to ensure `https` access is working as mentioned in [Closing External Ports](#closing-external-ports). Please refer to the following links to expose port `8081` and `8082`:

- [Open port in Azure VM](https://learn.microsoft.com/en-us/answers/questions/1190066/how-can-i-open-a-port-in-azure-so-that-a-constant)
- [Network security groups](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)


### 6. Configure Domain and Subdomains

Please follow [the instructions from GoDaddy](https://au.godaddy.com/help/add-a-subdomain-4080).

For simplcity, we want to have subdomains that reflects the differences of the two Web APIs like the following:

- `django-ninja.<DOMAIN_NAME>.com`
- `fast-api.<DOMAIN_NAME>.com`

### 7. Install and Configure Nginx
Please refer to the following articles on how to setup and configure Nnginx:

- [Install Nginx on Ubuntu 22.04](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-22-04)
- [Configure Nginx as a Reverse Proxy on Ubuntu 22.04](https://www.digitalocean.com/community/tutorials/how-to-configure-nginx-as-a-reverse-proxy-on-ubuntu-22-04)

### 8. Obtain SSL Certificates

Please follow the [instruction from Certbot official website](https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal).

### 9. Finalize Nginx Configuration
TODO: Include Nginx configuration files for each Web APIs.


## Testing
Open a browser and navigate to `https://django-ninja.domain.com` and `https://fast-api.domain.com` to verify the setup.


## Closing External Ports

Update the Azure NSG to block ports 8081 and 8082 from external access.


## Conclusion
This project demonstrates a complete workflow for securely hosting multiple web APIs using Docker and Nginx with SSL/TLS. Feel free to contribute, open issues, or use this as a reference for your own projects.

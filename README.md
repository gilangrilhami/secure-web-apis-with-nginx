# Secure Web APIs with Nginx and SSL
This project demonstrates how to set up two web APIs (Django Ninja and FastAPI) running in Docker containers, and securely expose them over HTTPS using Nginx as a reverse proxy. The project includes steps for configuring subdomains, obtaining SSL certificates with Certbot, and routing traffic to the appropriate services.

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

Authenticate to Azure Container Registry with Docker. Make sure that [`Admin user`](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-authentication?tabs=azure-cli#admin-account) is enabled.
```bash
docker login <ACR_NAME>.azurecr.io
```


**Dockerizing Django Ninja Web API**
```bash
cd django-ninja-api
docker build -t <ACR_NAME>.azurecr.io/web-api-django-ninja:v0.1.0 .
docker push <ACR_NAME>.azurecr.io/web-api-django-ninja:v0.1.0
```
**Dockerizing FastAPI Web API**
```bash
cd fastapi-api
docker build -t <ACR_NAME>.azurecr.io/web-api-fastapi:v0.1.0 .
docker push <ACR_NAME>.azurecr.io/web-api-fastapi:v0.1.0
```


### 5. Run Docker Containers

Enter the Azure VM via `ssh`.

```bash
ssh <VM_USER>@<VM_IP>
```

Running the Docker containers can be done either by `docker run` or `docker compose`.

**Using `docker run`**
```bash
# Django Ninja Web API
docker run --rm -p 8081:8000 -d <ACR_NAME>.azurecr.io/web-api-django-ninja:v0.1.0 uvicorn django_ninja_api.asgi:application --host 0.0.0.0 --port 8000

# FastAPI Web API
docker run --rm -p 8082:8000 -d <ACR_NAME>.azurecr.io/web-api-fastapi:v0.1.0 fastapi run main.py --host 0.0.0.0 --port 8000
```
**Using `docker compose`**

First, copy the `compose.yaml` from this repository file into Azure VM.

Then, replace the `build` key with the `image` key, and set the value to the build images on Azure Container Registry.

```bash
services:

  web-api-django-ninja:
    ...
    # build: ./django-ninja-api
    image: <ACR_NAME>.azurecr.io/web-api-django-ninja:v0.1.0
    ...

  web-api-fastapi:
    ...
    # build: ./fastapi-api
    image: <ACR_NAME>.azurecr.io/web-api-fastapi:v0.1.0
    ...
```
Finally, run `docker compose` command. Make sure to run this in the directory where `compose.yaml` file is located at.
```bash
docker compose -f compose.yaml -d up
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

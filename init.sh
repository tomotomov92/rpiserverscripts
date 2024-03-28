# Update system
sudo apt update
sudo apt upgrade -y

# Install docker
curl -sSL https://get.docker.com | sh

# Add user to docker group
sudo usermod -aG docker $USER

#Create docker directory and add permissions
sudo mkdir -p /docker
sudo chmod -R 777 /docker

# Create docker-compose.yaml file
nano docker-compose.yaml

# Add the text to the compose file
services:
  plex:
    image: lscr.io/linuxserver/plex:latest
    container_name: plex
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Sofia
    volumes:
      - /docker/plex:/config
      - /docker/testmedia:/testmedia
    restart: unless-stopped

# Pull docker image
docker compose pull

# Start docker containers
docker compose up -d

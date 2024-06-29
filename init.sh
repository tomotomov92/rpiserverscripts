# Update system
sudo apt update
sudo apt upgrade -y

# Install tailscale
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale set --advertise-exit-node
sudo tailscale up --advertise-routes=192.168.2.0/24 --ssh --advertise-exit-node

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

scp -r /home/deck/Downloads/testmedia tomo@192.168.1.103:/docker

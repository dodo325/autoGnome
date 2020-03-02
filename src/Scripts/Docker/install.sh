peints 'Install Docker'
curl -fsSL https://get.docker.com -o get-docker.sh; sh get-docker.sh; rm get-docker.sh

peints 'Install Docker: add in systemctl'
sudo systemctl enable docker
sudo systemctl status --no-pager docker

peints 'Install Docker: add user in docker groupe'
sudo usermod -aG docker ${USER}

peints 'Install Docker-compose: add user in docker groupe'

sudo apt-get install libffi-dev libssl-dev -y

sudo apt-get install -y python python-pip

sudo apt-get remove python-configparser -y

peints 'Install Docker'
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common python-pip
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –
sudo add-apt-repository deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable
sudo apt-get update
sudo apt-get install docker-ce

peints 'Install Docker: add in systemctl'
sudo systemctl status --no-pager docker

peints 'Install Docker: add user in docker groupe'
sudo usermod -aG docker ${USER}
# su - ${USER}
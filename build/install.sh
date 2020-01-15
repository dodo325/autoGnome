#!/bin/bash
#                   __           ____                                          
#                 /\ \__       /\  _`\                                        
#    __     __  __\ \ ,_\   ___\ \ \L\_\    ___     ___     ___ ___      __   
#  /'__`\  /\ \/\ \\ \ \/  / __`\ \ \L_L  /' _ `\  / __`\ /' __` __`\  /'__`\ 
# /\ \L\.\_\ \ \_\ \\ \ \_/\ \L\ \ \ \/, \/\ \/\ \/\ \L\ \/\ \/\ \/\ \/\  __/ 
# \ \__/.\_\\ \____/ \ \__\ \____/\ \____/\ \_\ \_\ \____/\ \_\ \_\ \_\ \____\
#  \/__/\/_/ \/___/   \/__/\/___/  \/___/  \/_/\/_/\/___/  \/_/\/_/\/_/\/____/

peints(){
  echo -e '\033[1;42m $1 \033[0m'
}

peints 'Install GIT'
sudo apt install git
sudo add-apt-repository ppa:atareao/telegram
sudo apt-get update
sudo apt-get install telegram
peints 'Install audacity'
sudo add-apt-repository ppa:ubuntuhandbook1/audacity
sudo apt-get update
sudo apt-get install -y audacity
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
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code # or code-insiders
rm -f microsoft.gpg
bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"
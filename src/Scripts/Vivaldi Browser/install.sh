sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main' 
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add - 
sudo apt update && sudo apt install vivaldi-stable -y


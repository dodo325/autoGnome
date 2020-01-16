peints 'Install Nautilus Terminal 3' #https://www.linuxuprising.com/2018/09/get-terminal-embedded-in-nautilus-file.html
# sudo apt install python-pip python-nautilus python-psutil
# pip2 install --user nautilus_terminal
sudo add-apt-repository ppa:flozz/nautilus-terminal -y
sudo apt update
sudo apt install nautilus-terminal -y

nautilus -q
sudo apt install dconf-editor -y

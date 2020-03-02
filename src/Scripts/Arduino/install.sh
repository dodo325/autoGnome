#wget https://www.arduino.cc/download_handler.php
prints "[info] Arduino installing...!"
sudo apt-get install gcc-avr avr-libc -y
sudo apt-get update && sudo apt-get install arduino arduino-core  -y
sudo usermod -aG dialout ${USER}

prints "[ok] Arduino installed!"

